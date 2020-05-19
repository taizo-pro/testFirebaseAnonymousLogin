//
//  NextViewController.swift
//  testFirebaseAnonymousLogin
//
//  Created by Kazuki Harada on 2020/05/13.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit
import SDWebImage
import Photos
import Firebase

class NextViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

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
        
        //アルバムの許可画面
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            case.authorized:print("許可されています")
            case.denied:print("拒否された")
            case.notDetermined:print("notDetermined")
            case.restricted:print("restricted")
            }
        }
        

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    //セルがタップされた時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userName = contentsArray[indexPath.row].userNameString
        userProfileImageString = contentsArray[indexPath.row].profileImage
        contentImageString = contentsArray[indexPath.row].contentImageString
        createData = contentsArray[indexPath.row].postDataString
        commentString = contentsArray[indexPath.row].commentString
        //画面遷移
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    //値を渡しながら画面遷移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.userName = userName
        detailVC.profileImage = userProfileImageString
        detailVC.contentImage = contentImageString
        detailVC.comment = commentString
        detailVC.postDate = createData
    }
    
    //カメラを起動
    func doCamera(){
        let sourceType:UIImagePickerController.SourceType = .camera
        //カメラが利用可能かチェックする
        if UIImagePickerController.isSourceTypeAvailable(.camera){
                let cameraPicker = UIImagePickerController()
                cameraPicker.sourceType = sourceType
                cameraPicker.delegate = self
                cameraPicker.allowsEditing = true
                present(cameraPicker, animated: true, completion: nil)
            }
        }
    
    //アルバムを起動
    func doAlbum(){
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        //カメラが利用可能かチェックする
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    //カメラ撮影orアルバムから画像選択された時に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
        selectedImage = info[.originalImage] as! UIImage
                
        //ナビゲーションを用いて画面遷移
        let EditPostVC = self.storyboard?.instantiateViewController(identifier:"EditPostVC") as! EditAndPostViewController
        EditPostVC.passedImage = selectedImage

        //Showで表示する
            self.navigationController?.pushViewController(EditPostVC, animated: true)
        
        //ピッカーを閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    
    //アラートの表示
    func showAlert(){
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか？", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            self.doCamera()
        }
        let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            self.doAlbum()
        }
        let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController,animated: true,completion: nil)
    }
    
    //カメラの画面を閉じる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        showAlert()
        
    }
    
    //DBのデータを取得する
    func fetchContentsData(){
        //最新100件を取得する
        let ref = Database.database().reference().child("timeLine").queryLimited(toLast: 100).queryOrdered(byChild: "postDate").observe(.value) { (snapShot) in
            
            self.contentsArray.removeAll()
            if let snapShot = snapShot.children.allObjects as? [DataSnapshot]{
                for snap in snapShot{
                    if let postData = snap.value as? [String:Any]{
                        let userName = postData["userName"] as? String
                        let profileImage = postData["profileImage"] as? String
                        let contentImage = postData["contentImage"] as? String
                        let comment = postData["comment"] as? String
                        var postDate:CLong?
                        if let postedDate = postData["postDate"] as? CLong{
                            postDate = postedDate
                        }
                        //postDateを時間に変換する
                        let timeString = self.convertTimeStamp(serverTimeStamp: postDate!)
                        self.contentsArray.append(Contents(userNameString: userName!, profileImage: profileImage!, contentImageString: contentImage!, commentString: comment!, postDataString: timeString))
                    }
                }
                
            self.timeLineTableView.reloadData()
                let indexPath = IndexPath(row: self.contentsArray.count - 1, section: 0)
                if self.contentsArray.count >= 5{
                    self.timeLineTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
    }
    
    func convertTimeStamp(serverTimeStamp:CLong)->String{
        let x = serverTimeStamp / 1000
        let date = Date(timeIntervalSince1970: TimeInterval(x))
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        return formatter.string(from: date)
    }
    
}
