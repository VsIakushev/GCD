//
//  SecondViewController.swift
//  GCD
//
//  Created by Vitaliy Sergeevich on 05.12.2022.
//  Copyright © 2022 Vitaliy Iakushev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3) {
            self.alertLogin()
        }
        
    }
    
    fileprivate func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    fileprivate func alertLogin() {
        let ac = UIAlertController(title: "Registered?", message: "Enter your login and passowrd", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Enter Login"
        }
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Enter Password"
            userPasswordTF.isSecureTextEntry = true
        }
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://sun9-3.userapi.com/impf/c624716/v624716356/1a8f5/Zahi-2FDWRs.jpg?size=600x450&quality=96&sign=989c21c15a192742cc7d1726422551be&type=album")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}

