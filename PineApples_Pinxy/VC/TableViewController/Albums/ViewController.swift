//
//  ViewController.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 23/04/24.
//

import UIKit
import SwiftUI
class ViewController: UIViewController {
    var images : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        extractView()
    }
    func extractView(){
        let hostView = UIHostingController(rootView: ContentView(images: images))
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(hostView.view)
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostView.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            hostView.view.heightAnchor.constraint(equalTo: view.heightAnchor),
        ]
        constraints.forEach({constraint in
            self.view.addConstraint(constraint)
        })
    }
}

