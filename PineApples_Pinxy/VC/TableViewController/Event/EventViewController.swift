//
//  EventViewController.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 23/04/24.
//

import UIKit

class EventViewController: UITableViewController {
//    func contactAdded(_ contact: ContactStruct) {
//        
//    }
//    
//    func contactRemoved(_ contact: ContactStruct) {
//        
//    }
    
    var selectedNames: [ContactStruct] = []
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
   
    @IBOutlet weak var addedFriends: UILabel!
    


    
    var eventName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        profileButtonUI()
        datePicker.minimumDate = Date()
        
    }

    @IBAction func EventName(_ sender: Any) {
    }
    // MARK: - Table view data source
    func profileButtonUI() {
        
        // Create a UIButton with a circular shape
        let circularButton = UIButton(type: .custom)
        circularButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40) // Adjust size as needed
        circularButton.layer.cornerRadius = circularButton.frame.size.width / 2
        circularButton.clipsToBounds = true

        circularButton.setImage(UIImage(named: "Image 2"), for: .normal)

        // Add constraints to make the button an exact circle
        circularButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        circularButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        // Create a UIBarButtonItem with the circular button as its custom view
        let barButtonItem = UIBarButtonItem(customView: circularButton)

        // Set the UIBarButtonItem in your navigation bar
        navigationItem.rightBarButtonItem = barButtonItem
        circularButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }



    
    @IBAction func createEventButtonTapped(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 2
        // Ensure event name is not empty
               guard let eventName = eventNameTextField.text, !eventName.isEmpty else {
                   showAlert(message: "Please enter event name.")
                   return
               }
               
               // Get selected date from date picker
               let eventDateTime = datePicker.date
               
               // Ensure at least one contact is selected
               guard !selectedNames.isEmpty else {
                   showAlert(message: "Please select at least one contact.")
                   return
               }
               
//             Create event instance
               let event = Event(name: eventName, dateTime: eventDateTime, contacts: selectedNames)
       

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  print("???? \(selectedFriends)")
        if segue.identifier == "goToContactVC" {
            if let navigationC = segue.destination as? UINavigationController, let contactVC = navigationC.topViewController as? ContactViewController {
                contactVC.delegate = self
                contactVC.selectedNames = selectedNames
            }
        }
    }
    private func showAlert(message: String) {
            let alertController = UIAlertController(title: "Incomplete Event Details", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
   
    // MARK: - Navigation

    
    @IBAction func unwindtoEvent(unwindSegue: UIStoryboardSegue){

    }
    
    @objc func profileButtonTapped() {
        // Instantiate the profile view controller
//       let profileVC = AccountViewController()
////
////        // Push or present the profile view controller based on your navigation requirement
//      navigationController?.pushViewController(profileVC, animated: true)
//        
    }


}
///// To be adjusted!

////
///
extension EventViewController: ContactTableViewControllerDelegate {
    func didSelectNames(_ names: [ContactStruct]) {
               selectedNames = names
        let selectedNamesText = selectedNames.map { "\($0.givenName) \($0.familyName)" }.joined(separator: ", ")
                
                addedFriends.text = selectedNamesText
    
    }
}
