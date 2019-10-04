//
//  AVAudioPlayer+Timer.swift
//  Smarock
//
//  Created by Guowei Mo on 13/01/2019.
//  Copyright © 2019 Smarock. All rights reserved.
//

import Foundation
import AVFoundation

extension AVAudioPlayer {
  
  private struct AVTimer {
    static var timer: Timer?
  }
  
  func observePlayback(updating progress: @escaping (Double) -> Void) {
    observePlayback { (current, duration) in
      progress(current / duration)
    }
  }
  
  func observePlayback(updating progress: @escaping (Double, Double) -> Void) {
    AVTimer.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { _ in
      progress(self.currentTime, self.duration)
    })
  }
}
