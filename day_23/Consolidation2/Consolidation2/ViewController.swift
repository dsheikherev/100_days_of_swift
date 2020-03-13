//
//  ViewController.swift
//  Consolidation2
//
//  Created by Denis Sheikherev on 27.02.2020.
//  Copyright © 2020 Denis Sheikherev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Atlas"
        
        let fm = FileManager.default
        let bundle = Bundle.main.resourcePath!
        
        do {
          let contents = try fm.contentsOfDirectory(atPath: bundle)

          for item in contents {
            if item.hasSuffix("png") {
                images.append(item)
            }
          }
        } catch {
          print(error)
        }
        images.sort()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = images[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVc.selectedImage = images[indexPath.row]
            navigationController?.pushViewController(detailVc, animated: true)
        }
    }
    
}

