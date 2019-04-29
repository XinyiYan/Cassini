//
//  ViewController.swift
//  Cassini
//
//  Created by yanxinyi on 2019-04-13.
//  Copyright © 2019 yanxinyi. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if imageURL == nil {
            imageURL = Bundle.main.url(forResource: "onmyoji", withExtension: "jpg")
        }
    }

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            imageView.image = newValue
            spinner?.stopAnimating()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/5
            scrollView.maximumZoomScale = 1.5
            scrollView.delegate = self
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    var imageURL: URL? {
        didSet {
            imageView?.image = nil
            if view.window != nil { // the view is on-screen
                fetchImage()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            
            // start spinner
            spinner.startAnimating()
            
            // do network fetch on other queue. this would stop apps from blocking
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                
                let content = try? Data(contentsOf: url)
                
                // should not make UI changes in a global queue. put it on main queue
                DispatchQueue.main.async {
                    if let imageData = content, url == self?.imageURL {
                        // this closure keeps self(view controller) in heap. however, if the closure takes too long to run, user may not care about self. So, make self weak.
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}

