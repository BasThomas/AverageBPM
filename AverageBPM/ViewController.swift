//
//  ViewController.swift
//  AverageBPM
//
//  Created by Bas Broek on 2/11/16.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
  
  @IBOutlet weak var averageBPMLabel: UILabel!
  let manager = HealthManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    manager.authorize { success, error in
      if success {
        self.manager.requestHeartRate(fromStartDate: 1.hourAgo, toEndDate: NSDate.now) { results, error in
          if let results = results {
            print(results)
            let average = results.reduce(0) { $0 + $1 } / Double(results.count)
            self.averageBPMLabel.text = "Average bpm in the last hour: ❤️\(average)"
          } else {
            print("Error: \(error?.localizedDescription)")
          }
        }
      } else {
        print("Denied: \(error?.localizedDescription)")
      }
    }
  }
}