//
//  RegisterViewController.swift
//  testFirebaseAnonymousLogin
//
//  Created by Kazuki Harada on 2020/05/13.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func login(_ sender: Any) {
        //匿名ログイン
        Auth.auth().signInAnonymously { (authResult, error) in
            let user = authResult?.user
            print(user)
            //画面遷移
            let inputVC = self.storyboard?.instantiateViewController(identifier:"inputVC") as! InputViewController
            self.navigationController?.pushViewController(inputVC, animated: true)
        }
        
    }
    


}
