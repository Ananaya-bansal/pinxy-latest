//
//  CustomTableViewCell.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 30/04/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var EventLabel: UILabel!
    @IBOutlet weak var LabelView: UILabel!
    
    override func awakeFromNib() {
                super.awakeFromNib()
            // Configure cell UI elements
                    iconImageView.layer.cornerRadius = 20 //
                    iconImageView.clipsToBounds = true
            }
    
}
