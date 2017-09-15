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
    
    //nil reference to remote firebase database
    var root: DatabaseReference!
    
    //backing array for tableView
    var messages:[String] = []

    //connections to UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the root firebase reference
        root = Database.database().reference()

        // start observing all messages
        observeMessages()
    }
    
    func observeMessages() {
        //YOUR CODE HERE
        
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        //YOUR CODE HERE
        
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

