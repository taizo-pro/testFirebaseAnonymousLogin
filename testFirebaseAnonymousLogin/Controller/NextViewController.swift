//
//  NextViewController.swift
//  testFirebaseAnonymousLogin
//
//  Created by Kazuki Harada on 2020/05/13.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit
import SDWebImage

class NextViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var timeLineTableView: UITableView!
    @IBOutlet weak var cameraButton: UIButton!
    
    var selectedImage = UIImage()
    var userName = String()
    var userImageData = Data()
    var userImage = UIImage()
    var commentString = String()
    var createData = String()
    var contentImageString = String()
    var userProfileImageString = String()
    
    var contentsArray = [Contents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        
        //キー値で保存したプロフィール画像、ユーザー名を引っ張ってくる
        //userDefaultsから取り出す時は以下のように記述する
        //ユーザー名を引っ張ってくる
        if UserDefaults.standard.object(forKey: "userName") != nil {
            userName = UserDefaults.standard.object(forKey: "userName") as! String
        }
        
        //プロフィール画像を引っ張ってくる
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            userImageData = UserDefaults.standard.object(forKey: "userImage") as! Data
            userImage = UIImage(data: userImageData)!
        }
        
//        //セルの高さを自動に設定する
//        timeLineTableView.rowHeight = UITableView.automaticDimension
//
//        //デフォルトのセルの高さを設定する
//        timeLineTableView.estimatedRowHeight = 10
        
    }
    

    //セルの数を決めるメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Firebaseから受信したものがそのまま反映される
        contentsArray.count
    }
    
    //セルに値を設定するメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルを取得する
        let cell = timeLineTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //コンテンツの表示
        //userNameString
        let userNameLabel = cell.viewWithTag(1) as! UILabel
        userNameLabel.text = contentsArray[indexPath.row].userNameString
        
        //profileImage
        let profileImageView = cell.viewWithTag(2) as! UIImageView
        profileImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].profileImage), completed: nil)
        profileImageView.layer.cornerRadius = 20
        
        //contentImageString
        let contentImageView = cell.viewWithTag(3) as! UIImageView
        contentImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].contentImageString), completed: nil)
        
        //commentString
        let commentLabel = cell.viewWithTag(4) as! UILabel
        commentLabel.text = contentsArray[indexPath.row].commentString
        
        //postDataString
        let postDataLabel = cell.viewWithTag(5) as! UILabel
        postDataLabel.text = contentsArray[indexPath.row].postDataString
        
        return cell
    }
    
    //セルのセクションを決めるメソッド
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //セルの高さを決めるメソッド
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return 605
    }
    
}
