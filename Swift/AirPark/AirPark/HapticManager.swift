//
//  HapticManager.swift
//  AirPark
//
//  Created by Jad on 3/11/23.
//

import Foundation
import SwiftUI

class HapticManager{
  static let instance = HapticManager()
  
  func notification(type: UINotificationFeedbackGenerator.FeedbackType){
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
  }
}
