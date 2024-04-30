//
//  EventsViewController.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 23/04/24.
//

import UIKit

class EventsViewController: UITableViewController {

    var eventName: String?
    var selectedFriends: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        dataStoreStack.layer.cornerRadius = 8 // Change the value to your desired corner radius
        eventDetailsStack.layer.cornerRadius = 8
       // LabelSection2.padding(<#T##SwiftUI.EdgeInsets#>)
        // Do any additional setup after loading the view.
        // datePicker?
    }
    
    @IBAction func EventName(_ sender: Any) {
        eventName = eventNameTextField.text
    }
   
    @IBOutlet weak var AddedFriends: UILabel!
    
    func updateFriends(){
        if !selectedFriends.isEmpty {
               AddedFriends.text = selectedFriends.joined(separator: ", ")
           } else {
               // If no friends are selected, you can set the text to indicate that no friends are selected
               AddedFriends.text = "No friends selected"
           }
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowCamera" {
         if let cameraVC = segue.destination as? CameraViewController {
             cameraVC.eventName = eventName
                cameraVC.selectedFriends = selectedFriends
           }
            }
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
        updateFriends()
        print(selectedFriends)
    }

}
