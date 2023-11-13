//
//  TaskExtension.swift
//  CarameloRun
//
//  Created by Luis Silva on 08/11/23.r
//

import SpriteKit
import GameKit

extension GameScene {
    func InsertTask() {
        let task1 = Tasks(scene!, localPlayer)
        entityManager.addEntity(task1)

        if let myEntity = entityManager.entities.first(where: { $0.component(ofType: ProgressBarComponent.self) != nil }) {
            myEntity.component(ofType: ProgressBarComponent.self)?.addProgressBar()
            myEntity.component(ofType: ProgressBarComponent.self)?.avaiable = true
        }
        
        if let myEntity2 = entityManager.entities.first(where: { $0.component(ofType: ProgressBarComponent.self) != nil }) {
            myEntity2.component(ofType: CompleteTaskComponent.self)?.addCompleteLabel()
            myEntity2.component(ofType: CompleteTaskComponent.self)?.TaskAvaiable(true)
        }
        
        
    }
    
    func verifyDoingTask(){
        if let myEntity = entityManager.entities.first(where: { $0.component(ofType: ProgressBarComponent.self) != nil }) {
            myEntity.component(ofType: ProgressBarComponent.self)!.verify(sendProgressToAllPlayers)
        }
    }
    
    
    func sendProgressToAllPlayers(_ state: ProgressState) {
        controllerDelegate?.sendProgress(state)
    }
    
//    func reciveProgress(_ state: ProgressState){
//        if let myEntity = entityManager.entities.first(where: { $0.component(ofType: ProgressBarComponent.self) != nil }) {
//            myEntity.component(ofType: ProgressBarComponent.self)?.progress = CGFloat(state.progress)
//            myEntity.component(ofType: ProgressBarComponent.self)?.progressBar.xScale = myEntity.component(ofType: ProgressBarComponent.self)!.progress
//            
//            if myEntity.component(ofType: ProgressBarComponent.self)!.progress >= 1.50 {
//                entity?.component(ofType: CompleteTaskComponent.self)?.changeLabel(true)
//                myEntity.component(ofType: ProgressBarComponent.self)?.avaiable = false
//                self.entity?.component(ofType: CompleteTaskComponent.self)?.ChangeAvaiable(false)
//                myEntity.component(ofType: ProgressBarComponent.self)?.progressBar.xScale = 0.00
//                localPlayer.component(ofType: ScoreComponent.self)?.dogMakeTask()
//                myEntity.component(ofType: ProgressBarComponent.self)?.initTimer()
//            }
//        }
//    }
}
