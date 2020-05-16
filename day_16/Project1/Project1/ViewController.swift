//
//  ViewController.swift
//  Project1
//
//  Created by Denis Sheikherev on 18.02.2020.
//  Copyright © 2020 Denis Sheikherev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        
        DispatchQueue.global().async {
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl") {
                    self.pictures.append(item)
                }
            }
            self.pictures.sort()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedImageNumber = indexPath.row + 1
            vc.totalNumberOfImages = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

