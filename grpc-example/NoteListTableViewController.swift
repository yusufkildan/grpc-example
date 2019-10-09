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
    
    private var notes: [Note] = []
    
    // MARK: - View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self,
                                  action: #selector(refresh(_:)),
                                  for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        loadData()
    }
    
    // MARK: - Load Data
    
    private func loadData() {
        Servie.listNotes { [weak self] (noteList, callResult) in
            DispatchQueue.main.async {
                if let noteList = noteList {
                    self?.notes = noteList.notes
                    self?.tableView.reloadData()
                    self?.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ button: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Note", message: "Fill the fields", preferredStyle: .alert)
        alertController.addTextField { $0.placeholder = "Title" }
        alertController.addTextField { $0.placeholder = "Content" }
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            let titleTextField = alertController.textFields![0]
            let contentTextField = alertController.textFields![1]
            guard let title = titleTextField.text, !title.isEmpty,
                let content = contentTextField.text, !content.isEmpty
                else {
                    return
            }
            
            let note = Note(title: title, content: content)
            Servie.insertNote(note: note) { [weak self](note, callResult) in
                DispatchQueue.main.async {
                    if let note = note {
                        self?.notes.append(note)
                        self?.tableView.reloadData()
                    }
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        loadData()
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        guard editingStyle == UITableViewCell.EditingStyle.delete else {
            return
        }
        
        let note = notes[indexPath.row]
        Servie.delete(noteId: note.id) { [weak self](empty, callResult) in
            DispatchQueue.main.async {
                self?.notes.remove(at: indexPath.row)
                self?.tableView.reloadData()
            }
        }
    }
}
