//
//  vjghfjkfjjhvvjjConnectionTableViewController.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 30/04/24.
//

import UIKit

class RequestConnectionTableViewController: UITableViewController {
    
    @IBOutlet weak var table: UITableView!
    
    
    let data: [Request] = [
        Request(userName: "Emily", phoneNo:2345654575, profileImage: "pic0"),
        Request(userName: "Ana", phoneNo:233434765, profileImage: "pic1"),
        Request(userName: "John", phoneNo:433544745, profileImage: "pic2"),
        Request(userName: "Emma", phoneNo:5356464645, profileImage: "pic4"),
        Request(userName: "Max", phoneNo:355554567, profileImage: "pic5"),
        Request(userName: "Ben", phoneNo:5545644578, profileImage: "pic3"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pic = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RequestTableViewCell
        cell.PhoneNo.text = "\(pic.phoneNo)"
        cell.UserName.text = pic.userName
        cell.ProfileImage.image = UIImage(named: pic.profileImage)
        
        // Add separator view
            let separatorView = UIView(frame: CGRect(x: 0, y: cell.frame.size.height - 1, width: tableView.frame.width, height: 1))
            separatorView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            cell.addSubview(separatorView)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}

