//
//  NoteListTableViewController.swift
//  grpc-example
//
//  Created by Scorp on 9.10.2019.
//  Copyright © 2019 Scorp. All rights reserved.
//

import UIKit
import SwiftGRPC

class NoteListTableViewController: UITableViewController {

    // MARK: - View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction addButtonTapped(_ button: UIBarButtonItem) {
        
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
    }
        
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
}
