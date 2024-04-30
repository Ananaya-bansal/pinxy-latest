//
//  ContactViewController.swift
//  Pinxy
//
//  Created by Ananaya on 14/04/24.
//

import UIKit
import Contacts
class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , ContactUpdateDelegate{
    func contactAdded(_ contact: ContactStruct) {
        ContactManager.shared.addContact(contact)
        tablesView.reloadData()
    }
    
    func contactRemoved(_ contact: ContactStruct) {
        ContactManager.shared.removeContact(contact)
        tablesView.reloadData()
    }
    
    
    
    @IBOutlet weak var tablesView: UITableView!
    var contactStore = CNContactStore()
    var contacts = [ContactStruct]()
    var eventName: String?
//    var selectedFriends: [String] = []
//    var selectedContacts:[ContactStruct] = ContactManager.shared.contacts
//    var selectedContact = ContactStruct?.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        tablesView.delegate = self
        tablesView.dataSource = self
        ContactManager.shared.delegate = self
        contactStore.requestAccess(for: .contacts) { (success, error) in
            if success {
                print("Authorization Successfull")
            }
        }
        
        fetchContacts()
        
        // Set table view background color
        view.backgroundColor = .black
        tablesView.backgroundColor = .black
        
        // Set table view separator color
        tablesView.separatorColor = .gray
        
    }
    // Set background color of the view and table view to black
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = .black
        let contactToDisplay = contacts[indexPath.row]
 
            var content = cell.defaultContentConfiguration()
        content.text = contactToDisplay.givenName + " " + contactToDisplay.familyName
        content.secondaryText = contactToDisplay.number
        content.image = contactToDisplay.givenImage
        
        cell.contentConfiguration = content
          
            // Set accessory type based on selection
           if ContactManager.shared.containsContact(contactToDisplay) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = contacts[indexPath.row]
        
        // Toggle selection: if the contact is already selected, deselect it; otherwise, select it
        if ContactManager.shared.containsContact(selectedContact) {
            ContactManager.shared.removeContact(selectedContact)
            
            
            //contactRemoved(selectedContact)
        } else {
            ContactManager.shared.addContact(selectedContact)
            
            //contactAdded(selectedContact)
        }
        
        // Reload the selected row to update the checkmark accessory type
        tableView.reloadRows(at: [indexPath], with: .none)
        
       

        
    }


    func fetchContacts() {
        let key = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataKey // Include CNContactImageDataKey to fetch thumbnail image data
        ] as [CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: key)
        
        do {
            try contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in
                let name = contact.givenName
                let familyName = contact.familyName
                let number = contact.phoneNumbers.first?.value.stringValue
                var image: UIImage?
                
                // Check if thumbnail image data is available
                if let imageData = contact.imageData {
                    // Convert image data to UIImage
                    image = UIImage(data: imageData)
                }
                
                let contactToAppend = ContactStruct(
                    givenName: name,
                    familyName: familyName,
                    number: number!,
                    givenImage: image ?? defaultImage! // Provide a default image if thumbnail image data is nil
                )
                
                self.contacts.append(contactToAppend)
            }
            
            tablesView.reloadData()
        } catch {
            print("Error fetching contacts: \(error.localizedDescription)")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "unwindtoEvent" {
//            if let eventsVC = segue.destination as? EventViewController {
//              //  eventsVC.selectedFriends = selectedFriends
//            }
//        }
    }
//        

    @IBAction func CancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindtoEvent", sender: self)
        
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
     
       performSegue(withIdentifier: "unwindtoEvent", sender: self)

   }
}
