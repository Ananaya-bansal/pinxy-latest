//
//  ConnectionTableViewController.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 30/04/24.
//

import UIKit

class ConnectionTableViewController: UITableViewController{
    
    
    
    let data: [Request] = [
        Request(UserName: "Emily", PhoneNo: 4567837465, ProfileImage: "pic0"),
        Request(UserName: "Emily", PhoneNo: 4567837465, ProfileImage: "pic0"),
        Request(UserName: "Emily", PhoneNo: 4567837465, ProfileImage: "pic0"),
        Request(UserName: "Emily", PhoneNo: 4567837465, ProfileImage: "pic0"),
        Request(UserName: "Emily", PhoneNo: 4567837465, ProfileImage: "pic0"),
        Request(UserName: "Emily", PhoneNo: 4567837465, ProfileImage: "pic0"),
       
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pic = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CustomConnectionTableViewCell
        
    
        let userToDisplay = data[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = userToDisplay.UserName
        content.secondaryText = String(userToDisplay.PhoneNo)
        content.image = UIImage(named: userToDisplay.ProfileImage)
        
        cell.contentConfiguration = content
        return cell
        
       
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 140
//    }
}
