//
//  CustomConnectionTableViewCell.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 30/04/24.
//

import UIKit

class CustomConnectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var PhoneNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        // Configure cell UI elements
//        ProfileImage.layer.cornerRadius = ProfileImage.bounds.width / 2
//                ProfileImage.clipsToBounds = true
//        }
//    func update(userInfo: Request) {
//        PhoneNo.text = "\(userInfo.PhoneNo)"
//        UserName.text = userInfo.UserName
//        ProfileImage.image = UIImage(named: userInfo.ProfileImage)
//    }
}

