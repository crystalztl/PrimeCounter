//
//  ResultTableViewController.swift
//  primeCounter
//
//  Created by Zhang Tianli on 2/12/18.
//  Copyright © 2018 tianli. All rights reserved.
//

import UIKit

class ResultTableViewController: UIViewController {
    
    var resultArray: [Int64] = []
    var primeCounter: PrimeCounter?
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var controlBtn: UIBarButtonItem!
    
    @IBAction func onTapControlBtn(_ sender: UIBarButtonItem) {
        if primeCounter != nil {
            if primeCounter!.isPaused {
                controlBtn.title = "Resume"
                primeCounter!.resume()
            }else{
                controlBtn.title = "Pause"
                primeCounter!.pause()
                
            }
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if primeCounter != nil {
            primeCounter!.delegate = self
            primeCounter!.startCounting()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopPrimeCounter()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        stopPrimeCounter()
        
    }
    
    fileprivate func stopPrimeCounter() {
        if primeCounter != nil {
            primeCounter!.stop()
        }
    }
    
}

extension ResultTableViewController: PrimeCounterDelegate {
    func didFoundPrime(prime: Int64) {
        DispatchQueue.main.async {
            self.resultArray.append(prime)
            self.tableView.reloadData()
        }
    }
}

extension ResultTableViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = "Prime found: \(resultArray[indexPath.row])"
        return cell
    }
}
