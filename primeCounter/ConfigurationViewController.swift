//
//  ConfigurationViewController.swift
//  primeCounter
//
//  Created by Zhang Tianli on 2/12/18.
//  Copyright © 2018 tianli. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    @IBOutlet var tfStart: UITextField!
    @IBOutlet var tfEnd: UITextField!
    @IBOutlet var tfThreads: UITextField!
    
    @IBAction func onTapCompute(_ sender: UIButton) {
        let primerCounter = PrimeCounter(start: Int64(tfStart.text!)!, end: Int64(tfEnd.text!)! , threads: Int(tfThreads.text!)!)
        performSegue(withIdentifier: "showComputeResult", sender: primerCounter)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ResultTableViewController, let primeCounter = sender as? PrimeCounter {
            viewController.primeCounter = primeCounter
        }
    }
    
    
}
