//
//  LobbyHelper.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 22/11/23.
//

import Foundation
import GameKit

//Handles game center match making logic
class LobbyHelper {
    
    private var imTheHost = false
    private var allPlayers = [LobbyPlayer]()
    private var catcherIndex: Int = 0
    var delegate: LobbyHelperDelegate?
    private var match: GKMatch?
    var allPlayersAreReadyToPlay = false
    
    func receivedData(_ match: GKMatch, _ data: Data, _ remotePlayer: GKPlayer) {
        receivedDefineCatcher(data)
        receivedSetPlayerAsReady(data)
    }
    
    func initLobby(_ match: GKMatch) {
        self.match = match
        match.delegate = delegate
        
        Task {
            
            updatePlayersArray(await getPlayersInitialInformation())
            
            let hostName = allPlayers[0].displayName
            if hostName == GKLocalPlayer.local.displayName {
                imTheHost = true
            }
            
            
            if (imTheHost) {
                pickCatcherAndNotifyPlayers(match)
            }
            
        }
        
    }
    
    //set local player to ready and send this information to everyone
    func getReadyToPlay() {
        let displayName = GKLocalPlayer.local.displayName
        let playerIndex = allPlayers.firstIndex(where: {$0.displayName == displayName})
        allPlayers[playerIndex!].ready = true
        
        sendReliableData(PlayerSetToReadyData(displayName: displayName))
        
        updatePlayersArray(allPlayers)
    }
    
    //get players of the match initial informations
    private func getPlayersInitialInformation() async -> [LobbyPlayer] {
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
    
    private func pickRandomCatcherArrayIndex(_ numberOfPlayers: Int) -> Int {
        return Int.random(in: 0...(numberOfPlayers - 1))
    }
    
    private func pickCatcherAndNotifyPlayers(_ match:GKMatch) {
        let catcherIndex = pickRandomCatcherArrayIndex(allPlayers.count)
        self.catcherIndex = catcherIndex
        allPlayers[catcherIndex].playerType = .man
        updatePlayersArray(allPlayers)
        
        sendReliableData(CatcherPlayerArrayIndexData(index: catcherIndex))
    }
    
    private func receivedDefineCatcher(_ data: Data) {
        
        if let catcherIndex = (try? decodeReceivedData(data, CatcherPlayerArrayIndexData.self))?.index {
            self.catcherIndex = catcherIndex
            updatePlayersArray(allPlayers)
        }
        
    }
    
    private func receivedSetPlayerAsReady(_ data: Data) {
        let dataJsonString = String(decoding: data, as: UTF8.self)
        
        let jsonData = dataJsonString.data(using: .utf8)!
        if let displayName = (try? JSONDecoder().decode(PlayerSetToReadyData.self, from: jsonData))?.displayName {
            for i in 0..<allPlayers.count {
                if allPlayers[i].displayName == displayName {
                    allPlayers[i].ready = true
                    break
                }
            }
        }
        updatePlayersArray(allPlayers)
    }
    
    //Update the array of players and notify the changes to the UI
    private func updatePlayersArray(_ newArray: [LobbyPlayer]) {
        allPlayers = newArray
        if catcherIndex < allPlayers.count {
            for i in 0..<allPlayers.count {
                allPlayers[i].playerType = .dog
            }
            allPlayers[catcherIndex].playerType = .man
        }
        
        var allPlayersReady = true
        for player in allPlayers {
            if player.ready == false {
                allPlayersReady = false
                break
            }
        }
        
        //Do not update the UI if there are no players
        if self.allPlayers.isEmpty {
            return
        }
        
        DispatchQueue.main.async {
            if allPlayersReady{
                self.delegate?.allPlayersAreReadyToPlay(self.allPlayers)
            } else {
                self.delegate?.lobbyPlayersDidChange(self.allPlayers)
            }
        }
    }
    
    private func sendReliableData(_ data: Codable) {
        do {
            let data = try JSONEncoder().encode(data)
            try? match?.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("FAIL => Unable to send data in LobbyHelper class")
        }
    }
    
    private func decodeReceivedData<T: Codable>(_ data: Data, _ type: T.Type) throws -> T where T : Decodable {
        let dataJsonString = String(decoding: data, as: UTF8.self)
        
        let jsonData = dataJsonString.data(using: .utf8)!
        
        return try JSONDecoder().decode(T.self, from: jsonData)
        
    }
}

struct CatcherPlayerArrayIndexData: Codable {
    let index: Int
}

struct PlayerSetToReadyData: Codable {
    let displayName: String
}

protocol LobbyHelperDelegate: GKMatchDelegate {
    func lobbyPlayersDidChange(_ players: [LobbyPlayer])
    func allPlayersAreReadyToPlay(_ players: [LobbyPlayer])
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer)
}



