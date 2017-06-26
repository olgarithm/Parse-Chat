//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Olga Andreeva on 6/26/17.
//  Copyright © 2017 Olga Andreeva. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatMessageField: UITextField!
    var returnedMessages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.getMessages), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return returnedMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        let firstMessage = returnedMessages[indexPath.row]
        cell.messageLabel.text = (firstMessage["text"] as! String)
        return cell
    }
    
    @IBAction func didClickSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message_fbu2017")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    func getMessages() {
        let query = PFQuery(className: "Message_fbu2017")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) in
            if let messages = messages {
                // do something with the array of object returned by the call
                self.returnedMessages = messages
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
