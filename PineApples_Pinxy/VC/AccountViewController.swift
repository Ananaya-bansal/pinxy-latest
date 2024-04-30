//
//  AccountViewController.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 26/04/24.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var ProfilePicture: UIImageView!
       
       @IBOutlet weak var username: UILabel!
       
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           //Circle Image
           ProfilePicture.layer.masksToBounds = true
           ProfilePicture.layer.cornerRadius = ProfilePicture.frame.height / 2
       }

       @IBAction func submitBtnTapped(_ sender: Any) {
           let vc = storyboard?.instantiateViewController(withIdentifier: "EditAccountViewController") as? EditAccountViewController
           vc?.data = username.text!
           vc?.delegate = self
           navigationController?.pushViewController(vc!, animated: true)
       }
       
   }

   extension AccountViewController: PassDataToVC {
       func passData(str: String) {
           username.text = str
       }


}
