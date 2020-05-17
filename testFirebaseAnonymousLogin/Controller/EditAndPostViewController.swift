//
//  EditAndPostViewController.swift
//  testFirebaseAnonymousLogin
//
//  Created by Kazuki Harada on 2020/05/15.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit
import Firebase

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
        
        //DBのchildを決める
        let timeLineDB = Database.database().reference().child("timeLine").childByAutoId()
        let storage = Storage.storage().reference(forURL: "")
        
        let key = timeLineDB.child("Profiles").childByAutoId().key
        let key2 = timeLineDB.child("Contents").childByAutoId().key
        
        let imageRef = storage.child("Profiles").child("\(String(describing: key!)).jpg")
        let imageRef2 = storage.child("Contents").child("\(String(describing: key2!)).jpg")
        
        var profileImageData = Data()
        var contentImageData = Data()

        if userProfileImageView.image != nil {
            profileImageData = (userProfileImageView.image?.jpegData(compressionQuality: 0.01)) as! Data
        }
        
        if contentImageView.image != nil {
            contentImageData = (contentImageView.image?.jpegData(compressionQuality: 0.01)) as! Data
        }
        
        //画像をStorageに入れる
        let uploadTask = imageRef.putData(profileImageData, metadata: nil) { (metaData, error) in
            if error != nil {
                print(error)
                return
            }
            let uploadTask2 = imageRef.putData(contentImageData, metadata: nil) { (metaData, error) in
                if error != nil {
                    print(error)
                    return
            }
            
            //StorageからURLをダウンロードする
                imageRef.downloadURL { (url, error) in
                    if url != nil {
                        imageRef2.downloadURL { (url2, error) in
                            if url2 != nil {
                                
                                //Dictionary型でDBに送信するものを準備する
                                let timeLineInfo = ["userName":self.userName as Any,]
                            }
                        }
                    }
                }
        }
        
    }

    
}
