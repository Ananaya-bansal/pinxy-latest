//
//  ContactViewController.swift
//  Pinxy
//
//  Created by Ananaya on 14/04/24.
//

import UIKit
import Contacts

protocol ContactTableViewControllerDelegate: AnyObject {
    //func didSelectNames(_ names: [String])
    func didSelectNames(_ names: [ContactStruct])
}

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    func contactAdded(_ contact: ContactStruct) {
//        ContactManager.shared.addContact(contact)
//        tablesView.reloadData()
//    }
//    
//    func contactRemoved(_ contact: ContactStruct) {
//        ContactManager.shared.removeContact(contact)
//        tablesView.reloadData()
//    }
    
    var delegate: ContactTableViewControllerDelegate?
   // var selectedNames: [String] = []
    var selectedNames: [ContactStruct] = []
    
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
//        ContactManager.shared.delegate = self
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
        content.text = contactToDisplay.givenName + contactToDisplay.familyName
        content.secondaryText = contactToDisplay.number
        content.image = contactToDisplay.givenImage
        
        cell.contentConfiguration = content
          
            // Set accessory type based on selection
           if ContactManager.shared.containsContact(contactToDisplay) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        
        
//        selectedNames.contains(contacts[indexPath.row].givenName)
        
        if selectedNames.contains(contacts[indexPath.row]) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let selectedName = contacts[indexPath.row].givenName
        let selectedName = contacts[indexPath.row]
        if selectedNames.contains(selectedName) {
            selectedNames.removeAll() { $0 == selectedName }
        } else {
            selectedNames.append(selectedName)
        }
        delegate?.didSelectNames(selectedNames)
        tableView.reloadData()
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
