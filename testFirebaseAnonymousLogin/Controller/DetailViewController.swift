//
//  DetailViewController.swift
//  testFirebaseAnonymousLogin
//
//  Created by Kazuki Harada on 2020/05/19.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    //NextViewControllerから値が渡ってくる
    var userName = String()
    var profileImage = String()
    var contentImage = String()
    var comment = String()
    var postDate = String()
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //受け取った値を画面に表示する
        userNameLabel.text = userName
        profileImageView.sd_setImage(with: URL(string:profileImage), completed: nil)
        contentImageView.sd_setImage(with: URL(string: contentImage), completed: nil)
        commentLabel.text = comment
        postDateLabel.text = postDate
        
    }
    
    @IBAction func share(_ sender: Any) {
        
        let items = [profileImage] as Any?
        let activityVC = UIActivityViewController(activityItems: items as! [Any], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    

}
