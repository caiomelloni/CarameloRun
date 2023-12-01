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
        
        task.component(ofType: ProgressBarComponent.self)?.verifyIfIsDoingTask()

    }
    
    func addToGeneral(_ task: Tasks) {
        task.component(ofType: CompleteTaskComponent.self)?.tasksCompleted += 1
        
        //TODO: fazer o update da barra de tarefas completas aqui
        let nTasksCompleted = numberOfTasksCompleted()
        NTasksCompleted.updateNumberOfTasksCompleted(nTasksCompleted)
        
        if nTasksCompleted >= Constants.numberOfTasksThatTheDogsNeedToBeAdopted {
            dogsCanBeAdopted = true
            changeTasksToAdopted(task1)
            changeTasksToAdopted(task2)
            changeTasksToAdopted(task3)
        }
        
    }
    
    func numberOfTasksCompleted() -> Int {
        return task1.component(ofType: CompleteTaskComponent.self)!.tasksCompleted + task2.component(ofType: CompleteTaskComponent.self)!.tasksCompleted + task3.component(ofType: CompleteTaskComponent.self)!.tasksCompleted
    }
    
    func verifyAdopted(_ task: Tasks) {
        task.component(ofType: CanBeAdoptedComponent.self)?.verifyIfTheDosHasBeenAdopted()
    }
    
    func changeTasksToAdopted(_ task: Tasks) {
        task.component(ofType: ProgressBarComponent.self)?.progress = 0.00
        task.component(ofType: ProgressBarComponent.self)?.progressBar.xScale = 0.00
        task.component(ofType: ProgressBarComponent.self)?.avaiable = false
        task.component(ofType: ProgressBarComponent.self)?.timerOfTheTaskAvaiableThatApearsForThePlayer.text = ""
        task.component(ofType: CompleteTaskComponent.self)?.dogsCanBeAdopted()
    }
    
}
