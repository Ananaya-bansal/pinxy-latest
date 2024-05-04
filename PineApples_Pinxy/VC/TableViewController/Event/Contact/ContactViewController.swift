import UIKit
import Contacts

protocol ContactTableViewControllerDelegate: AnyObject {
    func didSelectNames(_ names: [ContactStruct])
}

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var delegate: ContactTableViewControllerDelegate?
    var selectedNames: [ContactStruct] = []
    var contactStore = CNContactStore()
    var contacts = [ContactStruct]()
    var sourceVC: String?
    @IBOutlet weak var tablesView: UITableView!
    override func viewDidLoad() {
           super.viewDidLoad()
           overrideUserInterfaceStyle = .dark
           tablesView.delegate = self
           tablesView.dataSource = self
           contactStore.requestAccess(for: .contacts) { (success, error) in
               if success {
                   print("Authorization Successfull")
               }
           }
           
           fetchContacts()
           
           view.backgroundColor = .black
           tablesView.backgroundColor = .black
           tablesView.separatorColor = .gray
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if let sourceVC {
                       return selectedNames.count
                   } else {
                       return contacts.count
                   }
       }
       
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.backgroundColor = .black
    
            var contactToDisplay: ContactStruct
    
            if let sourceVC {
                contactToDisplay = selectedNames[indexPath.row]
            } else {
                contactToDisplay = contacts[indexPath.row]
            }
    
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
            let selectedName: ContactStruct // = contacts[indexPath.row]
            
            if let sourceVC {
                selectedName = selectedNames[indexPath.row]
            } else {
                selectedName = contacts[indexPath.row]
            }
            
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
                   
                   if let imageData = contact.imageData {
                       if let formattedImage = UIImage(data: imageData) {
                           let imageSize = CGSize(width: 40, height: 40)
                           UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
                           let imageBounds = CGRect(origin: .zero, size: imageSize)
                           UIBezierPath(roundedRect: imageBounds, cornerRadius: imageSize.width/2).addClip()
                           formattedImage.draw(in: imageBounds)
                           let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
                           UIGraphicsEndImageContext()
                           image = roundedImage
                       }
                   } else {
                       if let formattedImage = UIImage(systemName: "person.crop.circle.fill") {
                           let magentaImage = formattedImage.withTintColor(.magenta)
                           let imageSize = CGSize(width: 40, height: 40)
                           UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
                           let imageBounds = CGRect(origin: .zero, size: imageSize)
                           UIBezierPath(roundedRect: imageBounds, cornerRadius: imageSize.width/2).addClip()
                           magentaImage.draw(in: imageBounds)
                           let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
                           UIGraphicsEndImageContext()
                           image = roundedImage
                       }
                   }
                   
                   let contactToAppend = ContactStruct(
                       givenName: name,
                       familyName: familyName,
                       number: number ?? "",
                       givenImage: image ?? defaultImage!
                   )
                   
                   self.contacts.append(contactToAppend)
               }
               
               tablesView.reloadData()
           } catch {
               print("Error fetching contacts: \(error.localizedDescription)")
           }
       }
   

    @IBAction func CancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindtoEvent", sender: self)
        
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
     
       performSegue(withIdentifier: "unwindtoEvent", sender: self)

   }
}
////
////  ContactViewController.swift
////  Pinxy
////
////  Created by Ananaya on 14/04/24.
////
//
//import UIKit
//import Contacts
//
//protocol ContactTableViewControllerDelegate: AnyObject {
//    //func didSelectNames(_ names: [String])
//    func didSelectNames(_ names: [ContactStruct])
//}
//
//class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
////    func contactAdded(_ contact: ContactStruct) {
////        ContactManager.shared.addContact(contact)
////        tablesView.reloadData()
////    }
////
////    func contactRemoved(_ contact: ContactStruct) {
////        ContactManager.shared.removeContact(contact)
////        tablesView.reloadData()
////    }
//    
//    var delegate: ContactTableViewControllerDelegate?
//   // var selectedNames: [String] = []
//    var selectedNames: [ContactStruct] = []
//    var sourceVC: String?
//    
//    @IBOutlet weak var tablesView: UITableView!
//    var contactStore = CNContactStore()
//    var contacts = [ContactStruct]()
//    var eventName: String?
////    var selectedFriends: [String] = []
////    var selectedContacts:[ContactStruct] = ContactManager.shared.contacts
////    var selectedContact = ContactStruct?.self
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print(selectedNames)
//        print(sourceVC ?? "no")
//        overrideUserInterfaceStyle = .dark
//        tablesView.delegate = self
//        tablesView.dataSource = self
////        ContactManager.shared.delegate = self
//        contactStore.requestAccess(for: .contacts) { (success, error) in
//            if success {
//                print("Authorization Successfull")
//            }
//        }
//        
//        fetchContacts()
//        
//        // Set table view background color
//        view.backgroundColor = .black
//        tablesView.backgroundColor = .black
//        
//        // Set table view separator color
//        tablesView.separatorColor = .gray
//        
//    }
//    // Set background color of the view and table view to black
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let sourceVC {
//            return selectedNames.count
//        } else {
//            return contacts.count
//        }
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
//        cell.backgroundColor = .black
//        
//        var contactToDisplay: ContactStruct
//        
//        if let sourceVC {
//            contactToDisplay = selectedNames[indexPath.row]
//        } else {
//            contactToDisplay = contacts[indexPath.row]
//        }
// 
//        var content = cell.defaultContentConfiguration()
//        content.text = contactToDisplay.givenName + contactToDisplay.familyName
//        content.secondaryText = contactToDisplay.number
//        content.image = contactToDisplay.givenImage
//        
//        cell.contentConfiguration = content
//          
//            // Set accessory type based on selection
//           if ContactManager.shared.containsContact(contactToDisplay) {
//                cell.accessoryType = .checkmark
//            } else {
//                cell.accessoryType = .none
//            }
//        
//        
////        selectedNames.contains(contacts[indexPath.row].givenName)
//        
//        if selectedNames.contains(contacts[indexPath.row]) {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
//        
//        
//        return cell
//        
//        
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
////        let selectedName = contacts[indexPath.row].givenName
//        let selectedName = contacts[indexPath.row]
//        if selectedNames.contains(selectedName) {
//            selectedNames.removeAll() { $0 == selectedName }
//        } else {
//            selectedNames.append(selectedName)
//        }
//        delegate?.didSelectNames(selectedNames)
//        tableView.reloadData()
//    }
//    
//
//
//
//    func fetchContacts() {
//        let key = [
//            CNContactGivenNameKey,
//            CNContactFamilyNameKey,
//            CNContactPhoneNumbersKey,
//            CNContactImageDataKey // Include CNContactImageDataKey to fetch thumbnail image data
//        ] as [CNKeyDescriptor]
//        
//        let request = CNContactFetchRequest(keysToFetch: key)
//        
//        do {
//            try contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in
//                let name = contact.givenName
//                let familyName = contact.familyName
//                let number = contact.phoneNumbers.first?.value.stringValue
//                var image: UIImage?
//                
//                // Check if thumbnail image data is available
//                if let imageData = contact.imageData {
//                    // Convert image data to UIImage
//                    if let formattedImage = UIImage(data: imageData) {
//                        // Make the image round
//                        let imageSize = CGSize(width: 40, height: 40)
//                        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
//                        let imageBounds = CGRect(origin: .zero, size: imageSize)
//                        UIBezierPath(roundedRect: imageBounds, cornerRadius: imageSize.width/2).addClip()
//                        formattedImage.draw(in: imageBounds)
//                        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
//                        UIGraphicsEndImageContext()
//
//                        image = roundedImage
//                    }
//                }
//                else{
//                    if let formattedImage = UIImage(systemName: "person.crop.circle.fill") {
//                        // Change default tint to magenta
//                        let magentaImage = formattedImage.withTintColor(.magenta)
//
//                        // Make the image round
//                        let imageSize = CGSize(width: 40, height: 40)
//                        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
//                        let imageBounds = CGRect(origin: .zero, size: imageSize)
//                        UIBezierPath(roundedRect: imageBounds, cornerRadius: imageSize.width/2).addClip()
//                        magentaImage.draw(in: imageBounds)
//                        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
//                        UIGraphicsEndImageContext()
//
//                        image = roundedImage
//                    }
//
//                  
//                }
//
//                
//                let contactToAppend = ContactStruct(
//                    givenName: name,
//                    familyName: familyName,
//                    number: number ?? "",
//                    givenImage: image ?? defaultImage! // Provide a default image if thumbnail image data is nil
//                )
//                
//                self.contacts.append(contactToAppend)
//            }
//            
//            tablesView.reloadData()
//        } catch {
//            print("Error fetching contacts: \(error.localizedDescription)")
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        if segue.identifier == "unwindtoEvent" {
////            if let eventsVC = segue.destination as? EventViewController {
////              //  eventsVC.selectedFriends = selectedFriends
////            }
////        }
//    }
////    beautify
