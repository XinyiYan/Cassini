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
        let strings = ["a": "https://yys.res.netease.com/pc/zt/20170731172708/data/picture/20180928/6/2208x1242.jpg",
                       "b": "https://yys.res.netease.com/pc/zt/20170731172708/data/picture/20180918/19/2208x1242.jpg",
                       "c": "https://yys.res.netease.com/pc/zt/20170731172708/data/picture/20181120/1/2208x1242.jpg"]
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
