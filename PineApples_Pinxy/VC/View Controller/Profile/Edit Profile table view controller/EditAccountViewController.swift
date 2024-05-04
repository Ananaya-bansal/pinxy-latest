//
//  EditAccountViewController.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 26/04/24.
//

import UIKit

protocol PassDataToVC {
    func passData(str: String)
}
class EditAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var newusername: UITextField!
    @IBOutlet weak var newProfilePicture: UIImageView!
    
    var data = ""
    var delegate: PassDataToVC!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Circle Image
        newProfilePicture.layer.masksToBounds = true
        newProfilePicture.layer.cornerRadius = newProfilePicture.frame.height / 2
        
        newusername.text = data
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        newProfilePicture.image = image
        dismiss(animated: true)
    }
    
    @IBAction func BtnImagePicker(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func SaveBtnTapped(_ sender: Any) {
        delegate.passData(str: newusername.text!)
        navigationController?.popViewController(animated: true)
    }

  

}
