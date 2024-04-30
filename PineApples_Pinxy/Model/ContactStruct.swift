//
//  ContactStruct.swift
//  Pinxy
//
//  Created by Ananaya on 14/04/24.
//

import Foundation
import UIKit
let defaultImage = UIImage(systemName: "photo.on.rectangle.angled")

struct ContactStruct : Equatable{
    let givenName: String
    let familyName: String
    let number: String
    let givenImage : UIImage
  
    static func ==(lhs: ContactStruct, rhs: ContactStruct) -> Bool {
            return lhs.givenName == rhs.givenName &&
                   lhs.familyName == rhs.familyName &&
                   lhs.number == rhs.number
        }
    
}

protocol ContactUpdateDelegate: AnyObject {
    func contactAdded(_ contact: ContactStruct)
    func contactRemoved(_ contact: ContactStruct)
}

class ContactManager {
    static let shared = ContactManager()
    weak var delegate: ContactUpdateDelegate?
    public var contacts: [ContactStruct] = []
//    private(set) var contacts: [ContactStruct] {
//         get {
//             return contacts
//         }
//         set {
//             contacts = newValue
//         }
//     }

    func getAllContacts() -> [ContactStruct] { return self.contacts }
    func addContact(_ contact: ContactStruct) {
        contacts.append(contact)
      delegate?.contactAdded(contact)
    }

    func removeContact(_ contact: ContactStruct) {
        if let index = contacts.firstIndex(of: contact) {
            contacts.remove(at: index)
         delegate?.contactRemoved(contact)
        }
    }
    func containsContact(_ contact: ContactStruct) -> Bool {
           return contacts.contains(contact)
       }
}

// MARK: - Event Struct

struct Event {
    var name: String
    var dateTime: Date
    var contacts: [ContactStruct]
    var images:[UIImage]
}

struct PastAlbum {
    var EventDetails : [Event]
    var imageURL: UIImage
}

struct FriendsAlbum{
    var FriendDetails : [Event]
    var pastAlbums :[PastAlbum]
    
}

struct PersonalAccount{
    var name : String
    var username: String
    var email: String
    var phone: Int
    var dob: Date
    var image : UIImage
    
}

//class Personal{
//    static let
//}
struct Pic {
    let title: String
    let date: String
    let imageName: String
}
