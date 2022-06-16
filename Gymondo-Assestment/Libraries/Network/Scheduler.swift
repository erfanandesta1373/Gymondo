//
//  Scheduler.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import Foundation

final class Scheduler {

    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()

    static let mainScheduler = RunLoop.main

}
