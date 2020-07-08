//
//  RankingViewController.swift
//  insuubunkai
//
//  Created by 山田拓也 on 2020/03/11.
//  Copyright © 2020 山田拓也. All rights reserved.
//

import UIKit
import NCMB

class RankingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backConstraint: NSLayoutConstraint!
    
    // レイアウト設定　UIEdgeInsets については下記の参考図を参照。
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 2.0, bottom: 2.0, right: 2.0)
    // 1行あたりのアイテム数
    private let itemsPerRow: CGFloat = 2
    
    var normaluser1 = ""
    var normaluser2 = ""
    var normaluser3 = ""
    var normaluser4 = ""
    var normaluser5 = ""
    
    var harduser1 = ""
    var harduser2 = ""
    var harduser3 = ""
    var harduser4 = ""
    var harduser5 = ""
    
    var nu1Record = ""
    var nu2Record = ""
    var nu3Record = ""
    var nu4Record = ""
    var nu5Record = ""
    
    var hu1Record = ""
    var hu2Record = ""
    var hu3Record = ""
    var hu4Record = ""
    var hu5Record = ""
    
    let dispatchGroup = DispatchGroup()
    let queue1 = DispatchQueue(label: "キュー1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // デバイスによってセルのサイズを分岐
        let layout = UICollectionViewFlowLayout()
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            // 使用デバイスがiPhoneの場合
//            //layout.minimumLineSpacing = 5
//            let cellWidth = floor(collectionView.bounds.width * 0.45)
//            let cellHight = floor(cellWidth * 0.3)
//            layout.itemSize = CGSize(width: cellWidth, height: cellHight)
//            collectionView.collectionViewLayout = layout
//        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // 使用デバイスがiPadの場合
            // collectionの制約を変更
            let myAppBoundSize: CGSize = UIScreen.main.bounds.size
            backConstraint.constant = backConstraint.constant * 1.5
            leftConstraint.constant = myAppBoundSize.width * 0.35
            rightConstraint.constant = myAppBoundSize.width * 0.35
        }
        
        
        //難易度がNORMALであるオブジェクトを検索するクエリの作成
        let query1 = NCMBQuery.init(className: "record")!
        query1.whereKey("level", equalTo: 0)
        
        //難易度がHARDであるオブジェクトを検索するクエリの作成
        let query2 = NCMBQuery.init(className: "record")!
        query2.whereKey("level", equalTo: 1)
        
        // 昇順（bestrecordが低いものから順にソート）
        query1.order (byAscending: "bestrecord")
        query2.order (byAscending: "bestrecord")
        
//        //取得件数の指定
//        query1.limit = 5;
//        query2.limit = 5;
        
        
        queue1.async(group: dispatchGroup) {
            //検索(normal)の実行
            query1.findObjectsInBackground({(results, error) in
                if error != nil {
                    print("error", error ?? "")
                } else {
                    var res = results as! [NCMBObject]
                    
                    //ユーザー名を取得
                    self.normaluser1 = String(describing:res[0].object(forKey: "username") ?? "taro")
                    self.normaluser2 = String(describing:res[1].object(forKey: "username") ?? "taro")
                    self.normaluser3 = String(describing:res[2].object(forKey: "username") ?? "taro")
                    self.normaluser4 = String(describing:res[3].object(forKey: "username") ?? "taro")
                    self.normaluser5 = String(describing:res[4].object(forKey: "username") ?? "taro")
                    
                    print("normaluser1は" + self.normaluser1)
                    print("normaluser2は" + self.normaluser2)
                    print("normaluser3は" + self.normaluser3)
                    print("normaluser4は" + self.normaluser4)
                    print("normaluser5は" + self.normaluser5)

                    //最高記録を取得
                    self.nu1Record = String(describing:res[0].object(forKey: "bestrecord") ?? "1000")
                    self.nu2Record = String(describing:res[1].object(forKey: "bestrecord") ?? "1000")
                    self.nu3Record = String(describing:res[2].object(forKey: "bestrecord") ?? "1000")
                    self.nu4Record = String(describing:res[3].object(forKey: "bestrecord") ?? "1000")
                    self.nu5Record = String(describing:res[4].object(forKey: "bestrecord") ?? "1000")
                    
                }
            })
        }
        
        queue1.async(group: dispatchGroup) {
            //検索(hard)の実行
            query2.findObjectsInBackground({(results, error) in
                if error != nil {
                    print("error", error ?? "")
                } else {
                    var res = results as! [NCMBObject]
                    
                    //ユーザー名を取得
                    self.harduser1 = String(describing:res[0].object(forKey: "username") ?? "taro")
                    self.harduser2 = String(describing:res[1].object(forKey: "username") ?? "taro")
                    self.harduser3 = String(describing:res[2].object(forKey: "username") ?? "taro")
                    self.harduser4 = String(describing:res[3].object(forKey: "username") ?? "taro")
                    self.harduser5 = String(describing:res[4].object(forKey: "username") ?? "taro")
                    
                    print("harduser1は" + self.harduser1)
                    print("harduser2は" + self.harduser2)
                    print("harduser3は" + self.harduser3)
                    print("harduser4は" + self.harduser4)
                    print("harduser5は" + self.harduser5)
                    
                    //最高記録を取得
                    self.hu1Record = String(describing:res[0].object(forKey: "bestrecord") ?? "1000")
                    self.hu2Record = String(describing:res[1].object(forKey: "bestrecord") ?? "1000")
                    self.hu3Record = String(describing:res[2].object(forKey: "bestrecord") ?? "1000")
                    self.hu4Record = String(describing:res[3].object(forKey: "bestrecord") ?? "1000")
                    self.hu5Record = String(describing:res[4].object(forKey: "bestrecord") ?? "1000")
                    
                }
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24 // 表示するセルの数
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem + 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // セルの行間の設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    class ColumnFlowLayout: UICollectionViewFlowLayout {
        // After invalidateLayouts
        override func prepare() {
            super.prepare()
            self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
            self.sectionInsetReference = .fromSafeArea
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: "cell", for: indexPath)
        // 表示するセルを登録(先程命名した"cell")
        
        let cellLabel1 = cell.contentView.viewWithTag(1) as! UILabel
        
        dispatchGroup.wait(timeout: .now() + 10)
        
            //セルラベルにユーザー名と最高記録をランキング形式で表示
            if (String(indexPath.row) == "0") {
                cellLabel1.text = "NORMAL"
                let color = UIColor(red: 24/255, green: 24/255, blue: 120/255, alpha: 90/100)
                cellLabel1.textColor = color
                cellLabel1.font = UIFont.boldSystemFont(ofSize: 22)
            } else if (String(indexPath.row) == "1") {
                cellLabel1.text = ""
            } else if (String(indexPath.row) == "2") {
                cellLabel1.text = self.normaluser1
            } else if (String(indexPath.row) == "3") {
                cellLabel1.text = self.nu1Record + "秒"
            } else if (String(indexPath.row) == "4") {
                cellLabel1.text = self.normaluser2
            } else if (String(indexPath.row) == "5") {
                cellLabel1.text = self.nu2Record + "秒"
            } else if (String(indexPath.row) == "6") {
                cellLabel1.text = self.normaluser3
            } else if (String(indexPath.row) == "7") {
                cellLabel1.text = self.nu3Record + "秒"
            } else if (String(indexPath.row) == "8") {
                cellLabel1.text = self.normaluser4
            } else if (String(indexPath.row) == "9") {
                cellLabel1.text = self.nu4Record + "秒"
            } else if (String(indexPath.row) == "10") {
                cellLabel1.text = self.normaluser5
            } else if (String(indexPath.row) == "11") {
                cellLabel1.text = self.nu5Record + "秒"
            } else if (String(indexPath.row) == "12") {
                cellLabel1.text = "HARD"
                let color = UIColor(red: 200/255, green: 0/255, blue: 10/255, alpha: 90/100)
                cellLabel1.textColor = color
                cellLabel1.font = UIFont.boldSystemFont(ofSize: 22)
            } else if (String(indexPath.row) == "13") {
                cellLabel1.text = ""
            } else if (String(indexPath.row) == "14") {
                cellLabel1.text = self.harduser1
            } else if (String(indexPath.row) == "15") {
                cellLabel1.text = self.hu1Record + "秒"
            } else if (String(indexPath.row) == "16") {
                cellLabel1.text = self.harduser2
            } else if (String(indexPath.row) == "17") {
                cellLabel1.text = self.hu2Record + "秒"
            } else if (String(indexPath.row) == "18") {
                cellLabel1.text = self.harduser3
            } else if (String(indexPath.row) == "19") {
                cellLabel1.text = self.hu3Record + "秒"
            } else if (String(indexPath.row) == "20") {
                cellLabel1.text = self.harduser4
            } else if (String(indexPath.row) == "21") {
                cellLabel1.text = self.hu4Record + "秒"
            } else if (String(indexPath.row) == "22") {
                cellLabel1.text = self.harduser5
            } else if (String(indexPath.row) == "23") {
                cellLabel1.text = self.hu5Record + "秒"
            }
            
        return cell
    }
    
    
    @IBAction func tofirstAction(_ sender: UIButton) {
        performSegue(withIdentifier: "fromRankingtoFirst", sender: nil)
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
