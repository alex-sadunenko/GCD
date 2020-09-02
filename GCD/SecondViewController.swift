//
//  SecondViewController.swift
//  GCD
//
//  Created by Alex on 02.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageURL: URL?
    var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchImage()
        loginAlert()
    }
    
    func loginAlert() {
        let alertController = UIAlertController(title: "Зарегистрированы?", message: "Введите ваш логин и пароль", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        alertController.addTextField { (loginTF) in
            loginTF.placeholder = "Login"
        }
        alertController.addTextField { (passwordTF) in
            passwordTF.placeholder = "Password"
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    func fetchImage() {
        let imageURL = URL(string: "https://storge.pic2.me/upload/640/592a7002af21c.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)

            }
        }
    }

}
