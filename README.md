PINXY Documentation


Table of Contents
Introduction
Problem Statement
Solution Overview
Key Features
Usage


1. Introduction
Pinxy is a messaging app developed using Swift and Firebase. It allows users to send text messages, photos, and videos to each other in real-time. Users can also create accounts, update their profile pictures, and manage their conversations.
2. Problem Statement
In the era of digital photography, sharing event photos poses significant challenges. Existing social media apps limit the number of photos that can be shared at once, and creating a group compromises privacy and control. Additionally, photo management remains cumbersome, with many users struggling to locate specific pictures.
3. Solution Overview
PINXY addresses these challenges by offering a streamlined platform for event photo sharing and management. Users can create events within the app, enabling organized memories and collaborative sharing. With facial recognition and detection, users can exclusively share photos with individuals captured in the image, ensuring privacy and control.
4. Key Features
Event creation: Easily create events for organized photo sharing.
Collaborative sharing: Share event photos with friends and family.
Facial recognition: Exclusively share photos with individuals captured in the image.
Streamlined photo management: Effortlessly locate specific pictures of yourself and others.

5. Installation


To run PineApples_Pinxy on your local machine, follow these steps:

1. Clone the repository.
2. Open the project in Xcode.
3. Install Firebase dependencies using CocoaPods.
4. Set up Firebase project and configure Firebase Authentication and Firebase Storage.
5. Run the app on a simulator or physical device.


6. Dependencies

pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'GoogleSignIn'
pod 'MessageKit'
pod 'JGProgressHUD'
pod 'RealmSwift'
pod 'SDWebImage'


7. Usage
Creating events: Step-by-step guide to creating and managing events.
Sharing photos: Instructions for sharing event photos with collaborators.
Facial recognition: How to use facial recognition features for exclusive photo sharing.
Photo management: Tips for efficiently locating specific pictures within the app.


 Contributors

Ananaya ([GitHub](https://github.com/ananayabansal))


=============================================================================================
 UIView Extension
This Swift file contains an extension to the UIView class in UIKit, providing convenient computed properties to access common geometric properties of a view's frame. These properties include:
width: Represents the width of the view.
height: Represents the height of the view.
top: Represents the y-coordinate of the top edge of the view's frame.
bottom: Represents the y-coordinate of the bottom edge of the view's frame.
left: Represents the x-coordinate of the left edge of the view's frame.
right: Represents the x-coordinate of the right edge of the view's frame.
These properties simplify access to frame dimensions and positions, enhancing code readability and maintainability when working with views in iOS app development.

-----------------------------------------------------------------------


 StorageManager

The `StorageManager` class provides functionality for uploading and downloading files to and from Firebase Storage. It facilitates the management of profile pictures and message media within the PineApples_Pinxy messaging app.



---

DatabaseManager

The `DatabaseManager` class provides functionalities to interact with the Firebase Realtime Database within the PineApples_Pinxy messaging app. It handles user authentication, user data management, conversation creation, and message handling
ContactStruct

The `ContactStruct` represents a contact with properties for the given name, family name, phone number, and an image. It also provides an Equatable implementation for comparing contacts.

Contact Manager

The `ContactManager` is a singleton class responsible for managing contacts. It provides methods for adding, removing, and retrieving contacts.

Event Struct

The `Event` struct represents an event with properties for the name, date and time, and associated contacts.

Album Struct

The `Album` struct represents an album with details about an event and associated images.

Personal Account Struct

The `PersonalAccount` struct represents a user's personal account with properties for name, username, email, phone, date of birth, and image.

Pic Struct

The `Pic` struct represents a picture with properties for title, date, and image name.

Request Struct

The `Request` struct represents a request with properties for username, phone number, and profile image.

Event Model

The `EventModel` is a singleton class responsible for managing events. It provides methods for adding, removing, and retrieving events.


ListItem 
ListItem represents an item in a list, including its title, image type, and an array of image names.
ImageType is an enum representing different types of images.
ListSection is an enum representing sections in a list, with methods to retrieve items count and title.
MockData provides mock data for the list, including popular and coming soon items, and methods to add events and retrieve list sections.








