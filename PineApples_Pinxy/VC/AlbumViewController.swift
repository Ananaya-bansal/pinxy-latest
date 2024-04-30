//
//  AlbumViewController.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 30/04/24.
//

import UIKit

class AlbumTableViewController: UITableViewController {
    @IBOutlet weak var table: UITableView!
    
    
    let data: [Pic] = [
        Pic(title: "Ladakh Trip", date: "20 Mar 2024", imageName: "pic0"),
        Pic(title: "Vimeet's Birthday", date: "15 Jan 2024", imageName: "pic1"),
        Pic(title: "Reunion", date: "10 Jan 2024", imageName: "pic2"),
        Pic(title: "Manali Trip", date: "5 Jan 2024", imageName: "pic4"),
        Pic(title: "Trip", date: "25 Dec 2023", imageName: "pic3"),
        Pic(title: "DayOut", date: "4 Dec 2023", imageName: "pic5"),
        Pic(title: "Random", date: "25 Nov 2023", imageName: "pic6"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        } else {
           return data.count
//        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pic = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.EventLabel.text = pic.title
        cell.LabelView.text = pic.date
        cell.iconImageView.image = UIImage(named: pic.imageName)
        
        // Add separator view
            let separatorView = UIView(frame: CGRect(x: 0, y: cell.frame.size.height - 1, width: tableView.frame.width, height: 1))
            separatorView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            cell.addSubview(separatorView)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}
