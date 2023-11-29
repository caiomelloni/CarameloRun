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
        let task1 = Tasks(scene!, entityManager.localPlayer!)
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
            myEntity.component(ofType: ProgressBarComponent.self)!.verify()
        }
    }
}
