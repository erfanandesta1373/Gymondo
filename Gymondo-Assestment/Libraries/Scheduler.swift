//
//  Scheduler.swift
//  Gif
//
//  Created by Erfan Andesta on 09/05/2022.
//  Copyright © 2022 Erfan Andesta. All rights reserved.
//

import Foundation
import Combine

final class Scheduler {

    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()

    static let mainScheduler = RunLoop.main

}
