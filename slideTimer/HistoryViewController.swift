//
//  HistoryViewController.swift
//  slideTimer
//
//  Created by LARRY COMBS on 3/3/18.
//  Copyright © 2018 LARRY COMBS. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
  
    var data = ["one", "two", "three", "four", "five"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
 
        //ViewController.countArray.count
 
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            ViewController.removeCountArray(atIndex: indexPath.row)
            tableView.deleteRows(at: indexPath, with: .fade)
        }
    }*/
 
}

