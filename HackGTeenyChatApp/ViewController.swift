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
    
    var root: DatabaseReference!
    var messages:[String] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        root = Database.database().reference()
        observeMessages()
    }
    
    func observeMessages() {
        root.child("chat").observe(.childAdded, with: { snapshot in
            if let message = snapshot.value as? String, !message.isEmpty {
                self.messages.append(message)
                self.tableView.reloadData()
                let bottomIndex = IndexPath(row: self.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: bottomIndex, at: .bottom, animated: true)
            }
        })
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        if let message = messageTextField.text, !message.isEmpty {
            let childRef = root.child("chat").childByAutoId()
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

