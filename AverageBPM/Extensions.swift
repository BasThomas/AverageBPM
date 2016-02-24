//
//  Extensions.swift
//  Water
//
//  Created by Bas Broek on 06/01/16.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import HealthKit

// MARK: - HKQuantityType
extension HKQuantityType {
  
  static var heartRate: HKQuantityType {
    return self.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!
  }
}

// MARK: - NSDate
extension NSDate {
  
  static var now: NSDate {
    return NSDate()
  }
}

// MARK: - Int
extension Int {
  
  var hourAgo: NSDate {
    return NSDate(timeIntervalSinceNow: -(60 * 60))
  }
}

// MARK: - GCD

func mainQueue(closure: Void -> Void) {
  dispatch_async(
    dispatch_get_main_queue(),
    closure)
}