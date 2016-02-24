//
//  HealthManager.swift
//  Water
//
//  Created by Bas Broek on 06/01/16.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import UIKit
import HealthKit

class HealthManager {
  
  private let store = HKHealthStore()
  
  func authorize(completion: (success: Bool, error: NSError?) -> Void) {
    guard HKHealthStore.isHealthDataAvailable() else {
      completion(success: false, error: nil)
      return
    }
    
    let write: Set<HKSampleType> = []
    let read: Set<HKSampleType> = [HKQuantityType.heartRate]
    
    store.requestAuthorizationToShareTypes(write, readTypes: read) { success, error in
      completion(success: success, error: error)
    }
  }
  
  func requestHeartRate(fromStartDate startDate: NSDate, toEndDate endDate: NSDate, completion: (results: [Double]?, error: NSError?) -> Void) {
    guard startDate.timeIntervalSince1970 < endDate.timeIntervalSince1970 else {
      completion(results: nil, error: nil)
      return
    }
    
    let type = HKQuantityType.heartRate
    let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .None)
    
    let query = HKSampleQuery(sampleType: type, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil) { _, results, error in
      let doubleResults = (results as? [HKQuantitySample])?.map { $0.quantity.doubleValueForUnit(HKUnit(fromString: "count/min")) }
      mainQueue {
        completion(results: doubleResults, error: error)
      }
    }
    
    store.executeQuery(query)
  }
}