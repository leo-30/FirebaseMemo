//
//  LoginMenuViewController.swift
//  FirebaseMemo
//
//  Created by 原田澪 on 2019/12/08.
//  Copyright © 2019 MioHarada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginMenuViewController: UIViewController {
    
    let email: String! = nil
    let password: String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            // ...
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
