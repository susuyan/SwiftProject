//
//  ViewController.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/18.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import UIKit
import XCGLogger

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.title = "hello"
        
        imageView.kf.setImage(urlString: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LoginAction(_ sender: UIButton) {
        
        let test = Networking.newDefaultNetworking()
        test.request(.login(username: AppConstants.TestAcount.testUsername,
                            password: AppConstants.TestAcount.testPassword), success: { (json) in
            let user = UserModel.init(fromJson: json["data"])
            //            UserDefaults.standard.set(user.key, forKey: "Token")

            UserManager.shareInstance.storeUserData(user)
            
        }) { (error) in

        }
    }
    
    @IBAction func LogoutAction(_ sender: UIButton) {

        let test = Networking.newDefaultNetworking()

        test.request(.logout, success: { (json) in
           UserManager.shareInstance.clearUserData()


//            log.verbose(json)
            
        }) { (error) in

        }
        
    }
    @IBAction func babyAction(_ sender: UIButton) {
        
        print(UserManager.shareInstance.isLogin)
        
        let user = UserManager.shareInstance.user
        
        print(user.key)
        
    }
}

