//
//  HistoryViewController.swift
//  slideTimer
//
//  Created by LARRY COMBS on 3/3/18.
//  Copyright © 2018 LARRY COMBS. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    let timeEntriesArrayKey = "timeEntriesArrayKey"
    
    var model = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        model = SlideTimerUserDefaults().getAllEntries()
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editRows)), UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteRows))]
    }
    
    @objc private func editRows() {
        isEditing = !isEditing
    }
    
    @objc private func deleteRows() {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            var items = [String]()
            for indexPath in selectedRows  {
                items.append(model[indexPath.row])
            }
            for item in items {
                if let index = model.index(of: item) {
                    model.remove(at: index)
                }
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
            defaults.set(model, forKey: timeEntriesArrayKey)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            model.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            defaults.set(model, forKey: timeEntriesArrayKey)
        }
    }
}
