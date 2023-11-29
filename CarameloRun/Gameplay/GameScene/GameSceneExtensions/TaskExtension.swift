//
//  TaskExtension.swift
//  CarameloRun
//
//  Created by Luis Silva on 08/11/23.r
//

import SpriteKit
import GameKit

extension GameScene {
    
    func InsertTask(_ task: Tasks) {
        entityManager.addEntity(task)
        
        task.component(ofType: ProgressBarComponent.self)?.addProgressBar()
        task.component(ofType: ProgressBarComponent.self)?.addTimer()
        task.component(ofType: ProgressBarComponent.self)?.avaiable = true
        task.component(ofType: CompleteTaskComponent.self)?.addCompleteLabel()
        task.component(ofType: CompleteTaskComponent.self)?.TaskAvaiable(true)
        task.component(ofType: ProgressBarComponent.self)?.initTimerThatIsPossibleToDoTheTask()
        
    }
    
    func verifyDoingTask(_ task: Tasks){
        task.component(ofType: ProgressBarComponent.self)?.verify()

    }
    
    func addToGeneral(_ task: Tasks) {
        task.component(ofType: CompleteTaskComponent.self)?.tasksCompleted += 1
        
        //TODO: fazer o update da barra de tarefas completas aqui
        NTasksCompleted.updateNumberOfTasksCompleted(numberOfTasksCompleted())
        
    }
    
    func numberOfTasksCompleted() -> Int {
        return task1.component(ofType: CompleteTaskComponent.self)!.tasksCompleted + task2.component(ofType: CompleteTaskComponent.self)!.tasksCompleted + task3.component(ofType: CompleteTaskComponent.self)!.tasksCompleted
    }
}
