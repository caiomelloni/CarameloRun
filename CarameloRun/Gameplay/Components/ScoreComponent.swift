//
//  ScoreComponent.swift
//  CarameloRun
//
//  Created by Luis Silva on 06/11/23.
//

import SpriteKit
import GameplayKit

class ScoreComponent: GKComponent {
    var score: Int = 0
    
    //func for the dog
    // dog make task - done
    func dogMakeTask() {
        score = score + 10
    }
    
    // dog was catched - done
    func dogWasCatched() {
        score = score - 20
    }
    
    // dog freed his friend
    func dogSetfriendFree() {
        score = score + 3
    }
    
    // dog ran away
    func dogAdopted() {
        score = score + 41
    }
    
    // dog not adopted
    func dogNotAdopted() {
        score = score - 10
    }
    
    // ------------
    
    //func for the man
    // man catched dog - done
    func humanCatch() {
        score = score + 7
    }
    
    // man catched all the dogs - done
    func humanCatchAllDogs() {
        score = score + 24
    }
    
    //the max for both is 80 points
}
