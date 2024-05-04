//
//  ContactStruct.swift
//  Pinxy
//
//  Created by Ananaya on 14/04/24.
//

import Foundation
import UIKit

let defaultImage = UIImage(systemName: "person.crop.circle.fill")

struct ContactStruct: Equatable {
    let givenName: String
    let familyName: String
    let number: String
    let givenImage: UIImage
    
    static func ==(lhs: ContactStruct, rhs: ContactStruct) -> Bool {
        return lhs.givenName == rhs.givenName &&
               lhs.familyName == rhs.familyName &&
               lhs.number == rhs.number
    }
}

// MARK: - Contact Manager

class ContactManager {
    static let shared = ContactManager()
    public var contacts: [ContactStruct] = []

    func getAllContacts() -> [ContactStruct] { return self.contacts }
    
    func addContact(_ contact: ContactStruct) {
        contacts.append(contact)
    }
    
    func removeContact(_ contact: ContactStruct) {
        if let index = contacts.firstIndex(of: contact) {
            contacts.remove(at: index)
        }
    }
    
    func containsContact(_ contact: ContactStruct) -> Bool {
        return contacts.contains(contact)
    }
}

// MARK: - Event Struct

struct Event: Equatable {
    var name: String
    var dateTime: Date
    var contacts: [ContactStruct]
}

// MARK: - Album Struct

struct Album {
    var EventDetails: Event
    var image: [String] = []
}

// MARK: - Personal Account Struct

struct PersonalAccount {
    var name: String
    var username: String
    var email: String
    var phone: Int
    var dob: Date
    var image: UIImage
}

// MARK: - Pic Struct

struct Pic {
    let title: String
    let date: String
    let imageName: String
}

// MARK: - Request Struct

struct Request {
    let userName: String
    let phoneNo: Int
    let profileImage: String
}

// MARK: - Event Model

class EventModel {
    static let shared = EventModel()
    public static var events: [Event] = []
    public static var presentEvent: Event? = nil
     
    static func getAllEvents() -> [Event] { return self.events }
    
    static func addEvent(_ event: Event) { events.append(event) }
    
    static func removeEvent(_ event: Event) {
        if let index = events.firstIndex(of: event) {
            events.remove(at: index)
        }
    }
    
    static func containsEvent(_ event: Event) -> Bool {
        return events.contains(event)
    }
}
