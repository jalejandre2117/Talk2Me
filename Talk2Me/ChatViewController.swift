//
//  ChatViewController.swift
//  Talk2Me
//
//  Created by Jorge Alejandre on 12/9/18.
//  Copyright © 2018 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {
    
    

    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ChatViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        refreshControl.endRefreshing()

    }
    @objc func onTimer() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
// Add code to be run periodically
    }
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if (error != nil) {
                print(error.debugDescription)
                print(error!.localizedDescription)
            }
        }
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMessage()
    }
    
    func fetchMessage() {
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (response, error) in
            if let messages = response {
                self.messages = messages
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription as Any)
            }
            
        }

        
    }
    
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        /*chatMessage["user"] = PFUser.current()*/
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let chatMessage = messages[indexPath.row]
        cell.chatMessage.text = chatMessage["text"] as? String
        if let user = chatMessage["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }

        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
