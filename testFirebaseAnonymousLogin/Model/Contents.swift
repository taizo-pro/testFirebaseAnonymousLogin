//
//  Contents.swift
//  testFirebaseAnonymousLogin
//
//  Created by Kazuki Harada on 2020/05/14.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import Foundation

//Firebaseで送受信する際に、Dictionry型でまとめて送受信できるようにするため
class Contents{
    
    //複数の画面で共有するプロパティを作る
    var userNameString:String = ""
    var profileImage:String = ""
    var contentImageString:String = ""
    var commentString:String = ""
    var postDataString:String = ""
    
    //contentsモデルを初期化する時にどういう形にするか
    init(userNameString:String,profileImage:String,contentImageString:String,commentString:String,postDataString:String) {
        
        //自分の画面でどういう状態にするか
        self.userNameString = userNameString
        self.profileImage = profileImage
        self.contentImageString = contentImageString
        self.commentString = commentString
        self.postDataString = postDataString

    }
    
}

