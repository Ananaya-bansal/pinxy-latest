//
//  CustomRequestTableViewController.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 01/05/24.
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var PhoneNo: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
        // Configure cell UI elements
        ProfileImage.layer.cornerRadius = ProfileImage.bounds.width / 2
                ProfileImage.clipsToBounds = true
        }
}
