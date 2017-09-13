//
//  ViewController.swift
//  HackGTeenyChatApp
//
//  Created by Brian Wang on 9/13/17.
//  Copyright © 2017 BW. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    //reference to remote firebase database
    var root: DatabaseReference!
    
    //backing array for tableView
    var messages:[String] = []

    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        root = Database.database().reference()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        observeMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func observeMessages() {
        root.observe(.childAdded, with: { snapshot in
            if let message = snapshot.value as? String, !message.isEmpty {
                self.messages.append(message)
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        if let message = messageTextField.text, !message.isEmpty {
            let childRef = root.childByAutoId()
            childRef.setValue(message)
            messageTextField.text = ""
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
}

