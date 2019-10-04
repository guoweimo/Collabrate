//
//  File.swift
//  Smarock
//
//  Created by Guowei Mo on 08/09/2019.
//  Copyright © 2019 Smarock. All rights reserved.
//

import Foundation

class ConcurrentTasksManager: NSObject {
  
  private let serialQueue: DispatchQueue
  private let concurrentQueue: DispatchQueue
  private let semaphore: DispatchSemaphore
  private var tasksCount = 0
  init(value poolLimit: Int) {
    serialQueue = DispatchQueue(label: "com.smarock.serial")
    concurrentQueue = DispatchQueue(label: "com.smarock.concurrent", attributes: .concurrent)
    semaphore = DispatchSemaphore(value: poolLimit)
  }
  
  func enqueue(ayncTask: @escaping AsyncAction) {
    serialQueue.async {
      self.semaphore.wait(timeout: .distantFuture)
      self.tasksCount += 1
      print("tasksCount: \(self.tasksCount)")
      self.concurrentQueue.async {
        ayncTask {
          self.semaphore.signal()
          self.tasksCount -= 1
          print("tasksCount: \(self.tasksCount)")
        }
      }
    };
  }
  
}
