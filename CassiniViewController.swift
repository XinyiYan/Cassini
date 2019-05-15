//
//  CassiniViewController.swift
//  Cassini
//
//  Created by yanxinyi on 2019-04-14.
//  Copyright © 2019 yanxinyi. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    
    var urls: Dictionary<String, URL> = {
        let strings = ["a": "https://www.nasa.gov/sites/default/files/thumbnails/image/pia12567-1600.jpg",
                       "b": "https://www.nasa.gov/sites/default/files/thumbnails/image/pia21923-nasa.jpg",
                       "c": "https://www.nasa.gov/sites/default/files/thumbnails/image/pia17144-1041.jpg"]
        var urls = Dictionary<String, URL>()
        for (key, value) in strings {
            urls[key] = URL(string: value)
        }
        return urls
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if let url = urls[identifier] {
                if let ivc = segue.destination as? ImageViewController {
                    ivc.imageURL = url
                    ivc.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
}
