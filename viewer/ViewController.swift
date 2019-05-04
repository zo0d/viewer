//
//  ViewController.swift
//  viewer
//
//  Created by BJ on 2019-05-01.
//  Copyright © 2019 BJ. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.init()
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
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
        // Try loading the Detail view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // success; set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.imageIndex = pictures.firstIndex(of: pictures[indexPath.row])!
            vc.totalImages = pictures.count
            
            
            
            // now push it onto nav controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

