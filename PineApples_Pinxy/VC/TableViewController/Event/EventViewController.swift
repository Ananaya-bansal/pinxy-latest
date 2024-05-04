//
//  EventViewController.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 23/04/24.
//

import UIKit

class EventViewController: UITableViewController, UITextFieldDelegate {

    
    var selectedNames: [ContactStruct] = []
    var eventName: String?
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addedFriends: UILabel!
    


    
    override func viewDidLoad() {
            super.viewDidLoad()
            profileButtonUI()
            datePicker.minimumDate = Date()
            tableView.delegate = self
        }

        override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            eventNameTextField.resignFirstResponder()
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

    @IBAction func EventName(_ sender: Any) {
    }
    @IBAction func createEventButtonTapped(_ sender: UIButton) {
        
        // Ensure event name is not empty
                guard let eventName = eventNameTextField.text, !eventName.isEmpty else {
                    showAlert(message: "Please enter event name.")
                    return
                }
                guard !selectedNames.isEmpty else {
                    showAlert(message: "Please select at least one contact.")
                    return
                }
                // Get selected date from date picker
                let eventDateTime = datePicker.date

                // Create event instance
                let event = Event(name: eventName, dateTime: eventDateTime, contacts: selectedNames)
                EventModel.presentEvent = event
                print("EventVC \(EventModel.presentEvent)")
                self.tabBarController?.selectedIndex = 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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

       @IBAction func unwindtoEvent(unwindSegue: UIStoryboardSegue) {
       }

       @objc func profileButtonTapped() {
           // Instantiate the profile view controller
           if let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController {
               navigationController?.pushViewController(profileVC, animated: true)
           }
       }

   }

   extension EventViewController: ContactTableViewControllerDelegate {
       func didSelectNames(_ names: [ContactStruct]) {
           selectedNames = names
           let selectedNamesText = selectedNames.map { "\($0.givenName) \($0.familyName)" }.joined(separator: ", ")
           addedFriends.text = selectedNamesText
       }
   }
