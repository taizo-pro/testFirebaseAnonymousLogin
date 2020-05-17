//
//  EditAndPostViewController.swift
//  testFirebaseAnonymousLogin
//
//  Created by Kazuki Harada on 2020/05/15.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit

class EditAndPostViewController: UIViewController {
    
    //NextVCで持っていた、 selectedImage→passedImageに変換して、受け取る
    var passedImage = UIImage()
    
    var profileImageData = Data()
    var profileImage = UIImage()
    var userName = String()

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //アプリ内保存されている画像を取り出す
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            profileImageData = UserDefaults.standard.object(forKey: "userImage") as! Data
            //Data型からUIImage型に変更する
            profileImage = UIImage(data: profileImageData)!
        }
        
        //アプリ内保存されているユーザー名を取り出す
        if UserDefaults.standard.object(forKey: "userName") != nil {
            userName = UserDefaults.standard.object(forKey: "userName") as! String
        }
        
        userProfileImageView.image = profileImage
        userNameLabel.text = userName
        contentImageView.image = passedImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func postAction(_ sender: Any) {
    }
    
    
}
