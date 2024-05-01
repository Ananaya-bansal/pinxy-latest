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
        Request(UserName: "Emily", PhoneNo:2345654575, ProfileImage: "pic0"),
        Request(UserName: "Ana", PhoneNo:233434765, ProfileImage: "pic1"),
        Request(UserName: "John", PhoneNo:433544745, ProfileImage: "pic2"),
        Request(UserName: "Emma", PhoneNo:5356464645, ProfileImage: "pic4"),
        Request(UserName: "Max", PhoneNo:355554567, ProfileImage: "pic5"),
        Request(UserName: "Ben", PhoneNo:5545644578, ProfileImage: "pic3"),
       
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
        cell.PhoneNo.text = "\(pic.PhoneNo)"
        cell.UserName.text = pic.UserName
        cell.ProfileImage.image = UIImage(named: pic.ProfileImage)
        
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

