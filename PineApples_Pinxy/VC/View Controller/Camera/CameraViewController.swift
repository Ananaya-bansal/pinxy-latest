//
//  CameraViewController.swift
//  Pinxy
//
//  Created by Ananaya on 14/04/24.
//
import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    // MARK: - Properties
    
    var showNavigation: Bool = false
    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    var eventName: String?
    var events: Event?
    var isUsingFrontCamera = false
    var capturedImage: UIImage?
    
    // MARK: - UI Elements
    
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.magenta.cgColor
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkCameraPermissions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 150)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        setupNavigationBar()
        SwipeGestures()
        ChangeCamera()
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else { return }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted, .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    private func setUpCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                DispatchQueue.global().async {
                    session.startRunning()
                }
                self.session = session
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Actions
 
    @objc private func didTapTakePhoto() {
        print("working!")
        guard let videoConnection = output.connection(with: .video) else {
            print("No active video connection")
            return
        }

        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
 
    
    // MARK: - Navigation Bar Setup
    
    private func setupNavigationBar() {
        if let events {
            showNavigation = true
            let endEventButton = UIButton(type: .system)
            endEventButton.setTitle(" End Event ", for: .normal)
            endEventButton.tintColor = .white
            endEventButton.backgroundColor = .magenta
            endEventButton.layer.cornerRadius = 5
            endEventButton.addTarget(self, action: #selector(endEvent), for: .touchUpInside)
            
            let infoButton = UIButton(type: .system)
            infoButton.setTitle("i", for: .normal)
            infoButton.layer.borderColor = UIColor.magenta.cgColor
            infoButton.layer.cornerRadius = 50
            infoButton.layer.borderWidth = 10
            infoButton.tintColor = .magenta
            infoButton.addTarget(self, action: #selector(showEventInfo), for: .touchUpInside)
            
            let endEventBarButtonItem = UIBarButtonItem(customView: endEventButton)
            let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
            
            let rightButtons = [infoBarButtonItem, endEventBarButtonItem]
            navigationItem.rightBarButtonItems = rightButtons
            
            navigationController?.navigationBar.barTintColor = .magenta
            navigationController?.navigationBar.tintColor = .white
        }
        showNavigation = false
    }
    
    // MARK: - Other UI and Actions
    
    func ChangeCamera() {
        let toggleButton = UIButton(type: .system)
        toggleButton.setImage(UIImage(systemName: "camera.rotate"), for: .normal)
        toggleButton.addTarget(self, action: #selector(toggleCamera), for: .touchUpInside)
        toggleButton.tintColor = .white
        view.addSubview(toggleButton)
    }
    
    func handleEndEvent() {
        self.dismiss(animated: true, completion: nil)
        print("Event ended.")
    }
    
    @objc func endEvent() {
        let alert = UIAlertController(title: "End Event", message: "Are you sure you want to end \(eventName ?? "the event")?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "End", style: .destructive, handler: { _ in
            self.handleEndEvent()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func showEventInfo() {
        if let eventName = EventModel.presentEvent?.name {
            let message = "Event Name: \(eventName)\n\nFriends:\n\(EventModel.presentEvent?.contacts.count ?? 0)"
            let alert = UIAlertController(title: "Event Information", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Event Information", message: "No event data available.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func SwipeGestures() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .right, .left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        print(gesture.direction)
        switch gesture.direction {
        case .down:
            print("down swipe")
        case .up:
            print("up swipe")
            if let capturedImage = capturedImage {
                if let event = EventModel.presentEvent {
                    print(event)
                    performSegue(withIdentifier: "goToContactVCFromCamera", sender: event.contacts)
                }
            }
        case .left:
            print("left swipe")
        case .right:
            print("right swipe")
            if let capturedImage = capturedImage {
                // Perform actions for right swipe
            }
        default:
            print("other swipe")
        }
    }
    
    @objc func toggleCamera() {
        isUsingFrontCamera.toggle()
        guard let session = session else { return }
        session.inputs.forEach { session.removeInput($0) }
        let desiredPosition: AVCaptureDevice.Position = isUsingFrontCamera ? .front : .back
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: desiredPosition) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
            } catch {
                print("Error setting up camera input: \(error.localizedDescription)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToContactVCFromCamera" {
            if let contacts = sender as? [ContactStruct],
               let navigationC = segue.destination as? UINavigationController,
               let contactVC = navigationC.topViewController as? ContactViewController {
                contactVC.selectedNames = contacts
                contactVC.sourceVC = "Camera"
            }
        }
    }
}
// MARK: - AVCapturePhotoCaptureDelegate

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else { return }
        let image = UIImage(data: data)
        
        session?.stopRunning()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        
        self.navigationController?.navigationItem.backButtonDisplayMode = .default
        self.capturedImage = imageView.image!
        
        view.addSubview(imageView)
    }
}

// MARK: - Comments
//import UIKit
//import AVFoundation
//
//class CameraViewController: UIViewController {
//    // Handle navigationNeeded or not
//    var showNavigation: Bool = false
//    //Capture Session
//    var session : AVCaptureSession?
//    //Photo Session
//    let output = AVCapturePhotoOutput()
//    //Video Preview
//    let previewLayer = AVCaptureVideoPreviewLayer()
//    //Shutter button
//    var eventName: String?
//    // Event Info
//   // var events: [Event] = EventModel.getAllEvents()
//    
//    var events: Event?
//    
////    var selectedFriends: [String] = []
//    var isUsingFrontCamera = false
//    
//    var capturedImage: UIImage?
//    
//    private let shutterButton: UIButton = {
//        let button = UIButton(frame: CGRect(x:0 , y:0 , width :100, height : 100))
//        button.layer.cornerRadius = 50
//        button.layer.borderWidth = 10
//        button.layer.borderColor = UIColor.magenta.cgColor
//        return button
//    }()
//    
////    @objc func shutterButtonPressed(){
////        
////    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //if let events = EventModel.presentEvent {
//            self.events = EventModel.presentEvent
//        //}
//        
//        //print("viewDidLoad \(events)")
////      overrideUserInterfaceStyle = .dark
//        setupNavigationBar()
//        SwipeGestures()
//        ChangeCamera()
//        view.backgroundColor = .black
//        view.layer.addSublayer(previewLayer)
//        view.addSubview(shutterButton)
//        checkCameraPermissions()
//        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
//    
////        shutterButton.addTarget(self, action: #selector(shutterButtonPressed()), for: .touchUpInside)
//    }
//    private func checkCameraPermissions(){
//        switch AVCaptureDevice.authorizationStatus(for: .video){
//            
//        case .notDetermined:
//            //request
//            AVCaptureDevice.requestAccess(for: .video){
//                [weak self] granted in
//                guard granted else{
//                    return
//                }
//                DispatchQueue.main.async{
//                    self?.setUpCamera()
//                }
//            }
//        case .restricted:
//            break
//        case .denied:
//            break
//        case .authorized:
//            setUpCamera()
//        @unknown default:
//            break
//        }
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        previewLayer.frame = view.bounds
//        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 150)
//    }
//    private func setUpCamera(){
//        let session = AVCaptureSession()
//        if let device = AVCaptureDevice.default(for: .video){
//            do{
//                let input = try AVCaptureDeviceInput(device : device)
//                if session.canAddInput(input){
//                    session.addInput(input)
//                }
//                
//                // Add AVCapturePhotoOutput to the session
//                if session.canAddOutput(output) {
//                    session.addOutput(output)
//                }
//                
//                previewLayer.videoGravity = .resizeAspectFill
//                previewLayer.session = session
//                DispatchQueue.global().async {
//                    session.startRunning()
//                }
//                self.session = session
//            }
//            catch{
//                print(error)
//            }
//        }
//    }
//
////    private func setUpCamera(){
////        let session = AVCaptureSession()
////        if let device = AVCaptureDevice.default(for: .video){
////            do{
////                let input = try AVCaptureDeviceInput(device : device)
////                if session.canAddInput(input){
////                    session.addInput(input)
////                }
////                previewLayer.videoGravity = .resizeAspectFill
////                previewLayer.session = session
////                DispatchQueue.global().async {
////                    session.startRunning()
////                }
////                self.session = session
////            }
////            catch{
////                print(error)
////            }
////        }
////        
////    }
//    
//    @objc private func didTapTakePhoto(){
//        print("working!")
//        guard let videoConnection = output.connection(with: .video) else {
//            print("No active video connection")
//            return
//        }
//
//        // Capture photo using the video connection
//
//        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
//        
//    }
//}
//extension CameraViewController:AVCapturePhotoCaptureDelegate{
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo :  AVCapturePhoto , error : Error?) {
//        guard let data = photo.fileDataRepresentation() else{
//            return
//        }
//        let image = UIImage(data: data)
//        
//        session?.stopRunning()
//        let imageView = UIImageView(image : image)
//        imageView.contentMode = .scaleAspectFill
//        imageView.frame = view.bounds
//        
//        self.navigationController?.navigationItem.backButtonDisplayMode = .default
//        self.capturedImage = imageView.image!
//        
//        view.addSubview(imageView)
//    }
//    
//    
//    // setting up navigationcontroller
//    
//    func setupNavigationBar() {
//        if let events {
//            print(events)
//            //if(events ==) {
//                showNavigation = true
//                let endEventButton = UIButton(type: .system)
//                endEventButton.setTitle(" End Event ", for: .normal)
//                endEventButton.tintColor = .white
//                endEventButton.backgroundColor = .magenta
//                endEventButton.layer.cornerRadius = 5
//                endEventButton.addTarget(self, action: #selector(endEvent), for: .touchUpInside)
//                
//                let infoButton = UIButton(type: .system)
//                infoButton.setTitle("i", for: .normal)
//                infoButton.layer.borderColor = UIColor.magenta.cgColor
//                infoButton.layer.cornerRadius = 50
//                infoButton.layer.borderWidth = 10
//                infoButton.tintColor = .magenta
//                infoButton.addTarget(self, action: #selector(showEventInfo), for: .touchUpInside)
//                
//                let endEventBarButtonItem = UIBarButtonItem(customView: endEventButton)
//                let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
//                
//                let rightButtons = [infoBarButtonItem, endEventBarButtonItem]
//                navigationItem.rightBarButtonItems = rightButtons
//                
//                navigationController?.navigationBar.barTintColor = UIColor.magenta
//                navigationController?.navigationBar.tintColor = UIColor.white
//            ///}
//       // else {
//                
//            }
//        showNavigation = false
//        }
//    
//    func ChangeCamera(){
//        let toggleButton = UIButton(type: .system)
//           toggleButton.setImage(UIImage(systemName: "camera.rotate"), for: .normal)
//           toggleButton.addTarget(self, action: #selector(toggleCamera), for: .touchUpInside)
//           toggleButton.tintColor = .white
//           view.addSubview(toggleButton)
//           
//           // Set constraints for the toggle button
////           toggleButton.translatesAutoresizingMaskIntoConstraints = false
////           NSLayoutConstraint.activate([
////               toggleButton.trailingAnchor.constraint(equalTo: shutterButton.leadingAnchor, constant: -20),
////               toggleButton.centerYAnchor.constraint(equalTo: shutterButton.centerYAnchor),
////               toggleButton.widthAnchor.constraint(equalToConstant: 44),
////               toggleButton.heightAnchor.constraint(equalToConstant: 44)
////           ])
//    }
//    
//    func handleEndEvent() {
//        // Implement logic for ending the event here
//        self.dismiss(animated: true, completion: nil)
//        print("Event ended.")
//        //navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//    
//    @objc func endEvent() {
//        let alert = UIAlertController(title: "End Event", message: "Are you sure you want to end \(eventName ?? "the event")?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "End", style: .destructive, handler: { _ in
//            self.handleEndEvent()
//        }))
//        present(alert, animated: true, completion: nil)
//    }
//    
//    @objc func showEventInfo() {
//        if let eventName = EventModel.presentEvent?.name {
//            let message = "Event Name: \(eventName)\n\nFriends:\n\(EventModel.presentEvent?.contacts.count)"
//            let alert = UIAlertController(title: "Event Information", message: message, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
//            
//        } else {
//            let alert = UIAlertController(title: "Event Information", message: "No event data available.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
//        }
//        
//        
//    }
//    
//    
//    func SwipeGestures(){
//        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .right, .left]
//            for direction in directions {
//                let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
//                gesture.direction = direction
//                self.view.addGestureRecognizer(gesture)
//            }
//    }
//    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
//        print(gesture.direction)
//        switch gesture.direction {
//        case .down:
//            print("down swipe")
//        case .up:
//            print("up swipe")
//            if let capturedImage {
//                if let event = EventModel.presentEvent {
//                    print(event)
//                    performSegue(withIdentifier: "goToContactVCFromCamera", sender: event.contacts)
//                }
//            }
//        case .left:
//            print("left swipe")
//        case .right:
//            print("right swipe")
//            if let capturedImage {
//                
//                
//                
//
//                
//                //performSegue(withIdentifier: "goToContactVCFromCamera", sender: capturedImage)
//                // Segue and pass the data to the
//            }
//        default:
//            print("other swipe")
//        }
//    }
//    @objc func toggleCamera() {
//            // Toggle the flag
//            isUsingFrontCamera.toggle()
//            
//            // Remove existing inputs from session
//            guard let session = session else { return }
//            session.inputs.forEach { session.removeInput($0) }
//            
//            // Get the desired camera device
//            let desiredPosition: AVCaptureDevice.Position = isUsingFrontCamera ? .front : .back
//            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: desiredPosition) {
//                do {
//                    let input = try AVCaptureDeviceInput(device: device)
//                    if session.canAddInput(input) {
//                        session.addInput(input)
//                    }
//                } catch {
//                    print("Error setting up camera input: \(error.localizedDescription)")
//                }
//            }
//        }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "goToContactVCFromCamera" {
//                
//            
//                if let contacts = sender as? [ContactStruct], let navigationC = segue.destination as? UINavigationController, let contactVC = navigationC.topViewController as? ContactViewController {
//                    // Pass the contact data to SecondViewController
//                    
//                    
//                       contactVC.selectedNames = contacts
//                    contactVC.sourceVC = "Camera"
//                    
//                    
//                    //secondVC.contactData = contactData
//                }
//            }
//        }
//        
//}
//
//
//
