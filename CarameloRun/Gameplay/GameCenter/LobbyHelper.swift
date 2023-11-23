//
//  LobbyHelper.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 22/11/23.
//

import Foundation
import GameKit

class LobbyHelper {
    
    private var imTheHost = false
    private var allPlayers = [LobbyPlayer]()
    private var catcherIndex: Int = 0
    var delegate: LobbyHelperDelegate?
    private var match: GKMatch?
    
    func receivedData(_ match: GKMatch, _ data: Data, _ remotePlayer: GKPlayer) {
        receivedDefineCatcher(data)
        receivedSetPlayerAsReady(data)
        delegate?.lobbyPlayersDidChange(allPlayers)
    }
    
    func initLobby(_ match: GKMatch) {
        self.match = match
        
        Task {
            
            updatePlayersArray(await getAllPlayers())
            
            let bestHostName = (await match.chooseBestHostingPlayer())?.displayName
            if bestHostName == GKLocalPlayer.local.displayName {
                imTheHost = true
            }
            
            
            if (imTheHost) {
                pickCatcherAndNotifyPlayers(match)
            }
            
        }
        
    }
    
    func getReadyToPlay(_ match: GKMatch) {
        //MARK: set local player to ready and send this information to everyone
        let displayName = GKLocalPlayer.local.displayName
        let playerIndex = allPlayers.firstIndex(where: {$0.displayName == displayName})
        allPlayers[playerIndex!].ready = true
        
        do {
            let data = try JSONEncoder().encode(PlayerSetToReady(displayName: displayName))
            try? match.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("FAIL => nao conseguiu mandar que o player esta pronto")
        }
        
        updatePlayersArray(allPlayers)
    }
    
    private func getAllPlayers() async -> [LobbyPlayer] {
        guard let match = self.match else {
            print("Warning: match was nil in getallplayers function")
            return []
        }
        
        let localPlayerPhoto: UIImage? = try? await GKLocalPlayer.local.loadPhoto(for: .normal)
        
        let localPlayerInstance = LobbyPlayer(playerNumber: 0, displayName: GKLocalPlayer.local.displayName, playerType: .dog, photo: localPlayerPhoto)
        
        var players = [localPlayerInstance]
        
        let gameCenterPlayers = match.players
        
        for player in gameCenterPlayers {
            for i in 0..<players.count {
                let remotePlayerPhoto = try? await player.loadPhoto(for: .normal)
                if player.displayName < players[i].displayName {
                    players.insert(LobbyPlayer(playerNumber: 0, displayName: player.displayName, playerType: .dog, photo: remotePlayerPhoto), at: i)
                    break
                }
                
                if i == players.count - 1 {
                    players.append(LobbyPlayer(playerNumber: 0, displayName: player.displayName, playerType: .dog, photo: remotePlayerPhoto))
                }
            }
        }
        
        for i in 0..<players.count {
            players[i].playerNumber = i + 1
            players[i].ready = false
        }
        
        
        return players
        
    }
    
    private func catcherNumberArrayIndex(_ numberOfPlayers: Int) -> Int {
        return Int.random(in: 0...(numberOfPlayers - 1))
    }
    
    private func pickCatcherAndNotifyPlayers(_ match:GKMatch) {
        let catcherIndex = catcherNumberArrayIndex(allPlayers.count)
        self.catcherIndex = catcherIndex
        allPlayers[catcherIndex].playerType = .man
        updatePlayersArray(allPlayers)
        do {
            let data = try JSONEncoder().encode(CatcherPlayerArrayIndex(index: catcherIndex))
            try? match.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("FAIL => nao conseguiu mandar o player sorteado")
        }
    }
    
    private func receivedDefineCatcher(_ data: Data) {
        Task {
            if allPlayers.count == 0 {
                allPlayers = await getAllPlayers()
            }
            let dataJsonString = String(decoding: data, as: UTF8.self)
            
            let jsonData = dataJsonString.data(using: .utf8)!
            if let catcherIndex = (try? JSONDecoder().decode(CatcherPlayerArrayIndex.self, from: jsonData))?.index {
                print("received index: \(catcherIndex)")
                self.catcherIndex = catcherIndex
                updatePlayersArray(allPlayers)
            }
        }
        
    }
    
    private func receivedSetPlayerAsReady(_ data: Data) {
        let dataJsonString = String(decoding: data, as: UTF8.self)
        
        let jsonData = dataJsonString.data(using: .utf8)!
        if let displayName = (try? JSONDecoder().decode(PlayerSetToReady.self, from: jsonData))?.displayName {
            for i in 0..<allPlayers.count {
                if allPlayers[i].displayName == displayName {
                    allPlayers[i].ready = true
                    break
                }
            }
        }
        updatePlayersArray(allPlayers)
    }
    
    private func updatePlayersArray(_ newArray: [LobbyPlayer]) {
        allPlayers = newArray
        if catcherIndex < allPlayers.count {
            for i in 0..<allPlayers.count {
                allPlayers[i].playerType = .dog
            }
            allPlayers[catcherIndex].playerType = .man
        }
        DispatchQueue.main.async {
            self.delegate?.lobbyPlayersDidChange(self.allPlayers)
        }
    }
}

struct CatcherPlayerArrayIndex: Codable {
    let index: Int
}

struct PlayerSetToReady: Codable {
    let displayName: String
}

protocol LobbyHelperDelegate: AnyObject {
    func lobbyPlayersDidChange(_ players: [LobbyPlayer])
}

//MARK: handles received data
extension PreparingViewController: GKMatchDelegate{
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        lobbyHelper.receivedData(match, data, player)
    }
}

