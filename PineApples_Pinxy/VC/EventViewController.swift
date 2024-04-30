//
//  EventViewController.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 23/04/24.
//

import UIKit

class EventViewController: UITableViewController , ContactUpdateDelegate{
    func contactAdded(_ contact: ContactStruct) {
        
    }
    
    func contactRemoved(_ contact: ContactStruct) {
        
    }
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
   
    @IBOutlet weak var AddedFriends: UILabel!
    var eventName: String?
    var selectedFriends = ContactManager.shared.getAllContacts()
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateFriends()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func EventName(_ sender: Any) {
    }
    // MARK: - Table view data source
//    func updateFriends(){
//            if !selectedFriends.isEmpty {
//                let friendNames = selectedFriends.map { $0.givenName }
//                let friendNamesString = friendNames.joined(separator: ", ")
//                AddedFriends.text = friendNamesString
//            } else {
//                // If no friends are selected, you can set the text to indicate that no friends are selected
//                AddedFriends.text = "No friends selected"
//            }
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "showCamera" {
//         if let cameraVC = segue.destination as? CameraViewController {
//             cameraVC.eventName = eventName
//                cameraVC.selectedFriends = selectedFriends
//           }
//            }
//        }
//   
 
    
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
               guard !selectedFriends.isEmpty else {
                   showAlert(message: "Please select at least one contact.")
                   return
               }
               
//               // Create event instance
//               let event = Event(name: eventName, dateTime: eventDateTime, contacts: selectedFriends)
//        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  print("???? \(selectedFriends)")
        if let contactVC = segue.destination as? ContactViewController {
           // contactVC.selectedFriends = selectedFriends
        }
    }
    private func showAlert(message: String) {
            let alertController = UIAlertController(title: "Incomplete Event Details", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindtoEvent(unwindSegue: UIStoryboardSegue){
//        updateFriends()
       // print("----- \(selectedFriends)")
    }
  

}
///// To be adjusted!
//
////
