//
//  View2ViewController.swift
//  insuubunkai
//
//  Created by 山田拓也 on 2019/08/01.
//  Copyright © 2019 山田拓也. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation
import GoogleMobileAds

class View2ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,GADInterstitialDelegate {
    
    //テスト用ラベル
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var indicateLabel1: UILabel!
    
    @IBOutlet weak var indicateLabel2: UILabel!
    
    @IBOutlet weak var indicateLabel3: UILabel!
    
    @IBOutlet weak var inputLabel1: UILabel!
    
    @IBOutlet weak var inputLabel2: UILabel!
    
    @IBOutlet weak var inputLabel3: UILabel!
    
    @IBOutlet weak var inputLabel4: UILabel!
    
    @IBOutlet weak var timeCountLabel: UILabel!
    
    @IBOutlet weak var solveNumberLabel: UILabel!
    
    @IBOutlet weak var CollectionView1: UICollectionView!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nijisikiImage1: UIImageView!
    
    @IBOutlet weak var nijisikiImage2: UIImageView!
    
    @IBOutlet weak var insuuImage: UIImageView!
    
    @IBOutlet weak var gifImage: UIImageView!
    
    @IBOutlet weak var cat1Image: UIImageView!
    
    @IBOutlet weak var cat2Image: UIImageView!
    
    @IBOutlet weak var cat3Image: UIImageView!
    
    @IBOutlet weak var cat4Image: UIImageView!
    
    @IBOutlet weak var cat5Image: UIImageView!
    
    @IBOutlet weak var cat6Image: UIImageView!
    
    @IBOutlet weak var cat7Image: UIImageView!
    
    @IBOutlet weak var cat8Image: UIImageView!
    
    @IBOutlet weak var cat9Image: UIImageView!
    
    @IBOutlet weak var cat10Image: UIImageView!
    
    //トップ画面から受け取ったデータ
    var highscore2 = 0
    var level:Int = 0
    
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    var audioPlayerInstance2 : AVAudioPlayer! = nil
    
    var leftValue: Int = 0
    var rightValue: Int = 0
    
    var timer = Timer()
    var timeCount = 0
    
    var solveCount:Int = 0
    
    //GADInterstitial型の変数を宣言
    var interstitial: GADInterstitial!
    
    // 広告ユニットID
    let AdMobInID = "ca-app-pub-7071770782912768/7839053308"
    // テスト用広告ユニットID
    let TESTIn_ID = "ca-app-pub-3940256099942544/4411468910"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //ハイスコア表示のテスト
        //testLabel.text = highscore2
        
        //createAndLoadInterstitialメソッドの呼び出し
        interstitial = createAndLoadInterstitial()
        
        // timer処理
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.timeCount += 1
            //self.timeCount値をtimeCountLabelに代入
            self.timeCountLabel.text = "\(self.timeCount)秒"
        })
        
        let layout = UICollectionViewFlowLayout()
        
        // デバイスによって分岐
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // 使用デバイスがiPhoneの場合
            
            print("デバイス名は\(getDeviceInfo())")
            
//            let deviceName = UIDevice.current.modelName
//            let deviceVersion = UIDevice.current.systemVersion
//            print("device = \(deviceName)(\(deviceVersion))")
            //iPhone7だけ別
            
            if(getDeviceInfo() == "iPhone7")||(getDeviceInfo() == "iPhone7 Plus"){
                layout.minimumLineSpacing = 20
                let cellWidth = floor(CollectionView1.bounds.width * 0.26)
                layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
                CollectionView1.collectionViewLayout = layout
            }
            else {
                layout.minimumLineSpacing = 14
                let cellWidth = floor((self.view.frame.width * 0.75 - 100)/3)
                layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
                CollectionView1.collectionViewLayout = layout
                collectionViewHeightConstraint.constant = cellWidth * 4 + 52
                collectionViewWidthConstraint.constant = cellWidth * 3 + 28
            }
            
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            // 使用デバイスがiPadの場合
            //制約の修正
            leftConstraint.constant = self.view.frame.width * 0.3
            backTopConstraint.constant = 50
            backBottomConstraint.constant = 50
            
            layout.minimumLineSpacing = 20
            let cellWidth = floor((self.view.frame.width * 0.4 - 40)/3)
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            CollectionView1.collectionViewLayout = layout
            collectionViewHeightConstraint.constant = cellWidth * 4 + 60
            collectionViewWidthConstraint.constant = cellWidth * 3 + 40
            
//            let myAppBoundSize: CGSize = UIScreen.main.bounds.size
//            leftConstraint.constant = myAppBoundSize.width * 0.35
//            bottomConstraint.constant = myAppBoundSize.height * 0.25
        }
        
        // 解いた数の表示
        solveNumberLabel.text = ""
        if(solveCount != 0) {
            solveNumberLabel.text = "\(solveCount)問"
        }
        
        // 解いた数に応じて、画面上部に猫の画像を表示
        if (solveCount > 9) {
            cat1Image.image = UIImage(named: "cat1")
        }
        if (solveCount > 19) {
            cat2Image.image = UIImage(named: "cat2")
        }
        if (solveCount > 29) {
            cat3Image.image = UIImage(named: "cat3")
        }
        if (solveCount > 39) {
            cat4Image.image = UIImage(named: "cat4")
        }
        if (solveCount > 49) {
            cat5Image.image = UIImage(named: "cat5")
        }
        if (solveCount > 59) {
            cat6Image.image = UIImage(named: "cat6")
        }
        if (solveCount > 69) {
            cat7Image.image = UIImage(named: "cat7")
        }
        if (solveCount > 79) {
            cat8Image.image = UIImage(named: "cat8")
        }
        if (solveCount > 89) {
            cat9Image.image = UIImage(named: "cat9")
        }
        if (solveCount > 99) {
            cat10Image.image = UIImage(named: "cat10")
        }
        
        indicateLabel1.text = ""
        indicateLabel2.text = ""
        indicateLabel3.text = ""
        
        
        
        inputLabel1.text = ""
        inputLabel2.text = ""
        inputLabel3.text = ""
        inputLabel4.text = ""
        
        //難易度がNORMALなら-9〜9、HARDなら-15〜15
        let array1: [Int] = [-9,-8,-7,-6,-5,-4,-3,-2,-1,1,2,3,4,5,6,7,8,9]
        let array2: [Int] = [-15,-14,-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
        
        var ran1 = 0
        var ran2 = 0
        
        if (level == 0) {
            ran1 = array1.randomElement()!
            ran2 = array1.randomElement()!
        } else if (level == 1) {
            ran1 = array2.randomElement()!
            ran2 = array2.randomElement()!
        }
        
        
        if (ran1 == 15) && (ran2 == 15) {
            ran2 = ran2 - 1
        } else if (ran1 == -1) && (ran2 == -1) {
            ran2 = ran2 - 1
        } else if (ran1 == ran2) {
            ran2 = ran2 + 1
        }
        
        let indicateValue1 = ran1 + ran2
        let indicateValue2 = ran1 * ran2
        
        // バンドルした画像ファイルを読み込んで、二次式と因数用の画像を設定
        
        //2乗-2乗パターン
        if (indicateValue1 == 0) {
            let niji2 = UIImage(named: "二次式2乗")
            nijisikiImage2.image = niji2
            
            indicateLabel3.text = String(indicateValue2)
        }
        //通常パターン
        else {
            let niji1 = UIImage(named: "二次式")
            nijisikiImage1.image = niji1
            
            if(indicateValue1 > 0) {
                if (indicateValue1 == 1) {
                    indicateLabel1.text = "+"
                } else {
                    indicateLabel1.text = "+\(String(indicateValue1))"
                }
            } else if (indicateValue1 < 0) {
                if (indicateValue1 == -1) {
                    indicateLabel1.text = "-"
                } else {
                    indicateLabel1.text = String(indicateValue1)
                }
            }
            
            if(indicateValue2 > 0) {
                indicateLabel2.text = "+\(String(indicateValue2))"
            } else if (indicateValue2 < 0) {
                indicateLabel2.text = String(indicateValue2)
            }
        }
        
        let image2 = UIImage(named: "因数分解")
        insuuImage.image = image2
        
        
    }
    
    //インタースティシャル広告を読み込む
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: AdMobInID)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    //インタースティシャル広告の初期化
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        createAndLoadInterstitial()
    }
    
    //デバイス名取得用メソッド
    func getDeviceInfo () -> String{
        var size : Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        let code:String = String(cString:machine)

        let deviceCodeDic:[String:String] = [
            /* Simulator */
            "i386"      :"Simulator",
            "x86_64"    :"Simulator",
            /* iPod */
            "iPod1,1"   :"iPod Touch 1st",            // iPod Touch 1st Generation
            "iPod2,1"   :"iPod Touch 2nd",            // iPod Touch 2nd Generation
            "iPod3,1"   :"iPod Touch 3rd",            // iPod Touch 3rd Generation
            "iPod4,1"   :"iPod Touch 4th",            // iPod Touch 4th Generation
            "iPod5,1"   :"iPod Touch 5th",            // iPod Touch 5th Generation
            "iPod7,1"   :"iPod Touch 6th",            // iPod Touch 6th Generation
            "iPod9,1"   :"iPod Touch 7th",            // iPod Touch 7th Generation

            /* iPhone */
            "iPhone1,1"   :"iPhone 2G",                 // iPhone 2G
            "iPhone1,2"   :"iPhone 3G",                 // iPhone 3G
            "iPhone2,1"   :"iPhone 3GS",                // iPhone 3GS
            "iPhone3,1"   :"iPhone 4",                  // iPhone 4 GSM
            "iPhone3,2"   :"iPhone 4",                  // iPhone 4 GSM 2012
            "iPhone3,3"   :"iPhone 4",                  // iPhone 4 CDMA For Verizon,Sprint
            "iPhone4,1"   :"iPhone 4S",                 // iPhone 4S
            "iPhone5,1"   :"iPhone 5",                  // iPhone 5 GSM
            "iPhone5,2"   :"iPhone 5",                  // iPhone 5 Global
            "iPhone5,3"   :"iPhone 5c",                 // iPhone 5c GSM
            "iPhone5,4"   :"iPhone 5c",                 // iPhone 5c Global
            "iPhone6,1"   :"iPhone 5s",                 // iPhone 5s GSM
            "iPhone6,2"   :"iPhone 5s",                 // iPhone 5s Global
            "iPhone7,1"   :"iPhone 6 Plus",             // iPhone 6 Plus
            "iPhone7,2"   :"iPhone 6",                  // iPhone 6
            "iPhone8,1"   :"iPhone 6S",                 // iPhone 6S
            "iPhone8,2"   :"iPhone 6S Plus",            // iPhone 6S Plus
            "iPhone8,4"   :"iPhone SE",                 // iPhone SE
            "iPhone9,1"   :"iPhone 7",                  // iPhone 7 A1660,A1779,A1780
            "iPhone9,3"   :"iPhone 7",                  // iPhone 7 A1778
            "iPhone9,2"   :"iPhone 7 Plus",             // iPhone 7 Plus A1661,A1785,A1786
            "iPhone9,4"   :"iPhone 7 Plus",             // iPhone 7 Plus A1784
            "iPhone10,1"  :"iPhone 8",                  // iPhone 8 A1863,A1906,A1907
            "iPhone10,4"  :"iPhone 8",                  // iPhone 8 A1905
            "iPhone10,2"  :"iPhone 8 Plus",             // iPhone 8 Plus A1864,A1898,A1899
            "iPhone10,5"  :"iPhone 8 Plus",             // iPhone 8 Plus A1897
            "iPhone10,3"  :"iPhone X",                  // iPhone X A1865,A1902
            "iPhone10,6"  :"iPhone X",                  // iPhone X A1901
            "iPhone11,8"  :"iPhone XR",                 // iPhone XR A1984,A2105,A2106,A2108
            "iPhone11,2"  :"iPhone XS",                 // iPhone XS A2097,A2098
            "iPhone11,4"  :"iPhone XS Max",             // iPhone XS Max A1921,A2103
            "iPhone11,6"  :"iPhone XS Max",             // iPhone XS Max A2104
            "iPhone12,1"  :"iPhone 11",                 // iPhone 11
            "iPhone12,3"  :"iPhone 11 Pro",             // iPhone 11 Pro
            "iPhone12,5"  :"iPhone 11 Pro Max",         // iPhone 11 Pro Max
            "iPhone12,8"  :"iPhone SE 2nd",             // iPhone SE 2nd Generation

            /* iPad */
            "iPad1,1"   :"iPad 1 ",                     // iPad 1
            "iPad2,1"   :"iPad 2 WiFi",                 // iPad 2
            "iPad2,2"   :"iPad 2 Cell",                 // iPad 2 GSM
            "iPad2,3"   :"iPad 2 Cell",                 // iPad 2 CDMA (Cellular)
            "iPad2,4"   :"iPad 2 WiFi",                 // iPad 2 Mid2012
            "iPad2,5"   :"iPad Mini WiFi",              // iPad Mini WiFi
            "iPad2,6"   :"iPad Mini Cell",              // iPad Mini GSM (Cellular)
            "iPad2,7"   :"iPad Mini Cell",              // iPad Mini Global (Cellular)
            "iPad3,1"   :"iPad 3 WiFi",                 // iPad 3 WiFi
            "iPad3,2"   :"iPad 3 Cell",                 // iPad 3 CDMA (Cellular)
            "iPad3,3"   :"iPad 3 Cell",                 // iPad 3 GSM (Cellular)
            "iPad3,4"   :"iPad 4 WiFi",                 // iPad 4 WiFi
            "iPad3,5"   :"iPad 4 Cell",                 // iPad 4 GSM (Cellular)
            "iPad3,6"   :"iPad 4 Cell",                 // iPad 4 Global (Cellular)
            "iPad4,1"   :"iPad Air WiFi",               // iPad Air WiFi
            "iPad4,2"   :"iPad Air Cell",               // iPad Air Cellular
            "iPad4,3"   :"iPad Air China",              // iPad Air ChinaModel
            "iPad4,4"   :"iPad Mini 2 WiFi",            // iPad mini 2 WiFi
            "iPad4,5"   :"iPad Mini 2 Cell",            // iPad mini 2 Cellular
            "iPad4,6"   :"iPad Mini 2 China",           // iPad mini 2 ChinaModel
            "iPad4,7"   :"iPad Mini 3 WiFi",            // iPad mini 3 WiFi
            "iPad4,8"   :"iPad Mini 3 Cell",            // iPad mini 3 Cellular
            "iPad4,9"   :"iPad Mini 3 China",           // iPad mini 3 ChinaModel
            "iPad5,1"   :"iPad Mini 4 WiFi",            // iPad Mini 4 WiFi
            "iPad5,2"   :"iPad Mini 4 Cell",            // iPad Mini 4 Cellular
            "iPad5,3"   :"iPad Air 2 WiFi",             // iPad Air 2 WiFi
            "iPad5,4"   :"iPad Air 2 Cell",             // iPad Air 2 Cellular
            "iPad6,3"   :"iPad Pro 9.7inch WiFi",       // iPad Pro 9.7inch WiFi
            "iPad6,4"   :"iPad Pro 9.7inch Cell",       // iPad Pro 9.7inch Cellular
            "iPad6,7"   :"iPad Pro 12.9inch WiFi",      // iPad Pro 12.9inch WiFi
            "iPad6,8"   :"iPad Pro 12.9inch Cell",      // iPad Pro 12.9inch Cellular
            "iPad6,11"  :"iPad 5th WiFi",               // iPad 5th Generation WiFi
            "iPad6,12"  :"iPad 5th Cell",               // iPad 5th Generation Cellular
            "iPad7,1"   :"iPad Pro 12.9inch 2nd WiFi",  // iPad Pro 12.9inch 2nd Generation WiFi
            "iPad7,2"   :"iPad Pro 12.9inch 2nd",       // iPad Pro 12.9inch 2nd Generation Cellular
            "iPad7,3"   :"iPad Pro 10.5inch",           // iPad Pro 10.5inch A1701 WiFi
            "iPad7,4"   :"iPad Pro 10.5inch",           // iPad Pro 10.5inch A1709 Cellular
            "iPad7,5"   :"iPad 6th",                    // iPad 6th Generation WiFi
            "iPad7,6"   :"iPad 6th",                    // iPad 6th Generation Cellular
            "iPad7,11"  :"iPad 7th",                    // iPad 7th Generation WiFi
            "iPad7,12"  :"iPad 7th",                    // iPad 7th Generation Cellular
            "iPad8,1"   :"iPad Pro 11inch WiFi",        // iPad Pro 11inch WiFi
            "iPad8,2"   :"iPad Pro 11inch WiFi",        // iPad Pro 11inch WiFi
            "iPad8,3"   :"iPad Pro 11inch Cell",        // iPad Pro 11inch Cellular
            "iPad8,4"   :"iPad Pro 11inch Cell",        // iPad Pro 11inch Cellular
            "iPad8,5"   :"iPad Pro 12.9inch WiFi",      // iPad Pro 12.9inch WiFi
            "iPad8,6"   :"iPad Pro 12.9inch WiFi",      // iPad Pro 12.9inch WiFi
            "iPad8,7"   :"iPad Pro 12.9inch Cell",      // iPad Pro 12.9inch Cellular
            "iPad8,8"   :"iPad Pro 12.9inch Cell",      // iPad Pro 12.9inch Cellular
            "iPad11,1"  :"iPad Mini 5th WiFi",          // iPad mini 5th WiFi
            "iPad11,2"  :"iPad Mini 5th Cell",          // iPad mini 5th Cellular
            "iPad11,3"  :"iPad Air 3rd WiFi",           // iPad Air 3rd generation WiFi
            "iPad11,4"  :"iPad Air 3rd Cell"            // iPad Air 3rd generation Cellular
        ]

        if let deviceName = deviceCodeDic[code] {
            return deviceName
        }else{
            if code.range(of: "iPod") != nil {
                return "iPod Touch"
            }else if code.range(of: "iPad") != nil {
                return "iPad"
            }else if code.range(of: "iPhone") != nil {
                return "iPhone"
            }else{
                return "unknownDevice"
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12 // 表示するセルの数
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: "Cell", for: indexPath)
        // 表示するセルを登録(先程命名した"Cell")
        
        //セルの背景色を設定する。
        cell.backgroundColor = UIColor(red: 24/255,green: 127/255,blue: 196/255,alpha: 90/100)
        
        //UIColor(red: CGFloat(drand48()),
        //                               green: CGFloat(drand48()),
        //                               blue: CGFloat(drand48()),
        //                               alpha: 1.0)
        
        let cellLabel1 = cell.contentView.viewWithTag(1) as! UILabel
        
        
        if (String(indexPath.row) == "0") {
            cellLabel1.text = "7"
        } else if (String(indexPath.row) == "1") {
            cellLabel1.text = "8"
        } else if (String(indexPath.row) == "2") {
            cellLabel1.text = "9"
        } else if (String(indexPath.row) == "3") {
            cellLabel1.text = "4"
        } else if (String(indexPath.row) == "4") {
            cellLabel1.text = "5"
        } else if (String(indexPath.row) == "5") {
            cellLabel1.text = "6"
        } else if (String(indexPath.row) == "6") {
            cellLabel1.text = "1"
        } else if (String(indexPath.row) == "7") {
            cellLabel1.text = "2"
        } else if (String(indexPath.row) == "8") {
            cellLabel1.text = "3"
        } else if (String(indexPath.row) == "9") {
            cellLabel1.text = "+"
        } else if (String(indexPath.row) == "10") {
            cellLabel1.text = "0"
        } else if (String(indexPath.row) == "11") {
            cellLabel1.text = "-"
        }

        
        cellLabel1.textColor = UIColor.white
        
        // CollectionView1を指定の位置に配置
        //CollectionView1.bottom = 670
        //CollectionView1.left = 67
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 210, height: 310)
//
//
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print(CollectionView1)
//
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (inputLabel1.text == "") {
            if (String(indexPath.row) == "0") {
                inputLabel1.text = ""
            } else if (String(indexPath.row) == "1") {
                inputLabel1.text = ""
            } else if (String(indexPath.row) == "2") {
                inputLabel1.text = ""
            } else if (String(indexPath.row) == "3") {
                inputLabel1.text = ""
            } else if (String(indexPath.row) == "4") {
                inputLabel1.text = ""
            } else if (String(indexPath.row) == "5") {
                inputLabel1.text = ""
            } else if (String(indexPath.row) == "6") {
                inputLabel1.text = ""
            } else if (String(indexPath.row) == "7") {
                inputLabel1.text = ""
            } else if (String(indexPath.row) == "8") {
                inputLabel1.text = ""
            } else if (String(indexPath.row) == "9") {
                inputLabel1.text = "+"
            } else if (String(indexPath.row) == "10") {
                inputLabel1.text = ""
            } else if (String(indexPath.row) == "11") {
                inputLabel1.text = "-"
            }
        } else if (inputLabel2.text == "") {
            if (String(indexPath.row) == "0") {
                inputLabel2.text = "7"
            } else if (String(indexPath.row) == "1") {
                inputLabel2.text = "8"
            } else if (String(indexPath.row) == "2") {
                inputLabel2.text = "9"
            } else if (String(indexPath.row) == "3") {
                inputLabel2.text = "4"
            } else if (String(indexPath.row) == "4") {
                inputLabel2.text = "5"
            } else if (String(indexPath.row) == "5") {
                inputLabel2.text = "6"
            } else if (String(indexPath.row) == "6") {
                inputLabel2.text = "1"
            } else if (String(indexPath.row) == "7") {
                inputLabel2.text = "2"
            } else if (String(indexPath.row) == "8") {
                inputLabel2.text = "3"
            } else if (String(indexPath.row) == "9") {
                inputLabel1.text = "+"
            } else if (String(indexPath.row) == "10") {
                inputLabel2.text = "0"
            } else if (String(indexPath.row) == "11") {
                inputLabel1.text = "-"
            }
        } else if (inputLabel2.text != "")&&(inputLabel3.text == "") {
            let int = Int(inputLabel2.text!)!
            
            if (String(indexPath.row) == "0") {
                let int0 = int * 10 + 7
                if(int0 < 100){
                    inputLabel2.text = String(int0)
                }
            } else if (String(indexPath.row) == "1") {
                let int1 = int * 10 + 8
                if(int1 < 100){
                    inputLabel2.text = String(int1)
                }
            } else if (String(indexPath.row) == "2") {
                let int2 = int * 10 + 9
                if(int2 < 100){
                    inputLabel2.text = String(int2)
                }
            } else if (String(indexPath.row) == "3") {
                let int3 = int * 10 + 4
                if(int3 < 100){
                    inputLabel2.text = String(int3)
                }
            } else if (String(indexPath.row) == "4") {
                let int4 = int * 10 + 5
                if(int4 < 100){
                    inputLabel2.text = String(int4)
                }
            } else if (String(indexPath.row) == "5") {
                let int5 = int * 10 + 6
                if(int5 < 100){
                    inputLabel2.text = String(int5)
                }
            } else if (String(indexPath.row) == "6") {
                let int6 = int * 10 + 1
                if(int6 < 100){
                    inputLabel2.text = String(int6)
                }
            } else if (String(indexPath.row) == "7") {
                let int7 = int * 10 + 2
                if(int7 < 100){
                    inputLabel2.text = String(int7)
                }
            } else if (String(indexPath.row) == "8") {
                let int8 = int * 10 + 3
                if(int8 < 100){
                    inputLabel2.text = String(int8)
                }
            } else if (String(indexPath.row) == "9") {
                inputLabel3.text = "+"
            } else if (String(indexPath.row) == "10") {
                let int10 = int * 10 + 0
                if(int10 < 100){
                    inputLabel2.text = String(int10)
                }
            } else if (String(indexPath.row) == "11") {
                inputLabel3.text = "-"
            }
        } else if (inputLabel4.text == "") {
            if (String(indexPath.row) == "0") {
                inputLabel4.text = "7"
            } else if (String(indexPath.row) == "1") {
                inputLabel4.text = "8"
            } else if (String(indexPath.row) == "2") {
                inputLabel4.text = "9"
            } else if (String(indexPath.row) == "3") {
                inputLabel4.text = "4"
            } else if (String(indexPath.row) == "4") {
                inputLabel4.text = "5"
            } else if (String(indexPath.row) == "5") {
                inputLabel4.text = "6"
            } else if (String(indexPath.row) == "6") {
                inputLabel4.text = "1"
            } else if (String(indexPath.row) == "7") {
                inputLabel4.text = "2"
            } else if (String(indexPath.row) == "8") {
                inputLabel4.text = "3"
            } else if (String(indexPath.row) == "9") {
                inputLabel3.text = "+"
            } else if (String(indexPath.row) == "10") {
                inputLabel4.text = "0"
            } else if (String(indexPath.row) == "11") {
                inputLabel3.text = "-"
            }
        } else if (inputLabel4.text != "") {
            let int = Int(inputLabel4.text!)!
            
            if (String(indexPath.row) == "0") {
                let int0 = int * 10 + 7
                if (int0 < 100) {
                    inputLabel4.text = String(int0)
                }
            } else if (String(indexPath.row) == "1") {
                let int1 = int * 10 + 8
                if (int1 < 100) {
                    inputLabel4.text = String(int1)
                }
            } else if (String(indexPath.row) == "2") {
                let int2 = int * 10 + 9
                if (int2 < 100) {
                    inputLabel4.text = String(int2)
                }
            } else if (String(indexPath.row) == "3") {
                let int3 = int * 10 + 4
                if (int3 < 100) {
                    inputLabel4.text = String(int3)
                }
            } else if (String(indexPath.row) == "4") {
                let int4 = int * 10 + 5
                if (int4 < 100) {
                    inputLabel4.text = String(int4)
                }
            } else if (String(indexPath.row) == "5") {
                let int5 = int * 10 + 6
                if (int5 < 100) {
                    inputLabel4.text = String(int5)
                }
            } else if (String(indexPath.row) == "6") {
                let int6 = int * 10 + 1
                if (int6 < 100) {
                    inputLabel4.text = String(int6)
                }
            } else if (String(indexPath.row) == "7") {
                let int7 = int * 10 + 2
                if (int7 < 100) {
                    inputLabel4.text = String(int7)
                }
            } else if (String(indexPath.row) == "8") {
                let int8 = int * 10 + 3
                if (int8 < 100) {
                    inputLabel4.text = String(int8)
                }
            } else if (String(indexPath.row) == "9") {
                inputLabel3.text = "+"
            } else if (String(indexPath.row) == "10") {
                let int10 = int * 10 + 0
                if (int10 < 100) {
                    inputLabel4.text = String(int10)
                }
            } else if (String(indexPath.row) == "11") {
                inputLabel3.text = "-"
            }
        }
        
        
        if (inputLabel1.text == "+")&&(inputLabel2.text != "") {
            leftValue = Int(inputLabel2.text ?? "0")!
        } else if (inputLabel1.text == "-")&&(inputLabel2.text != "") {
            leftValue  = Int(inputLabel2.text ?? "0")! * (-1)
        }
        
        if (inputLabel3.text == "+")&&(inputLabel4.text != "") {
            rightValue = Int(inputLabel4.text ?? "0")!
        } else if (inputLabel3.text == "-")&&(inputLabel4.text != "") {
            rightValue  = Int(inputLabel4.text ?? "0")! * (-1)
        }
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        if(inputLabel4.text != "") {
            inputLabel4.text = ""
        } else if(inputLabel3.text != "") {
            inputLabel3.text = ""
        } else if(inputLabel2.text != "") {
            inputLabel2.text = ""
        } else if(inputLabel1.text != "") {
            inputLabel1.text = ""
        }
    }
    
    @IBAction internal func enterButton(_ sender: UIButton) {
        let a: Int
        let b: Int
        
        //2乗-2乗のパターン
        if(indicateLabel3.text != "") {
            a = 0
            b = Int(indicateLabel3.text ?? "0")!
        }
        //通常パターン
        else {
            if(indicateLabel1.text == "+") {
                a = 1
            } else if (indicateLabel1.text == "-") {
                a = -1
            } else {
                a = Int(indicateLabel1.text ?? "0")!
            }
            
            b = Int(indicateLabel2.text ?? "0")!
        }
        
        
        
        //正解だった時
        if(leftValue + rightValue == a)&&(leftValue * rightValue == b) {
            //solveCountを1増やす
            solveCount = solveCount + 1
            
            // サウンドファイルのパスを生成
            let soundFilePath = Bundle.main.path(forResource: "Quiz-Correct", ofType: "mp3")!
            
            let sound:URL = URL(fileURLWithPath: soundFilePath)
            
            // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
            do {
                audioPlayerInstance1 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
            } catch {
                print("AVAudioPlayerインスタンス作成でエラー")
            }
            // 再生準備
            audioPlayerInstance1.prepareToPlay()
            
            // 再生箇所を頭に移す
            audioPlayerInstance1.currentTime = 0
            // 再生する
            audioPlayerInstance1.play()
            
            gifImage.image = UIImage(named: "丸（透過）")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // 1.5秒後に実行する処理
                // imageを削除
                self.gifImage.removeFromSuperview()
                self.nijisikiImage1.removeFromSuperview()
                self.nijisikiImage2.removeFromSuperview()
                
                // timerの一時停止
                self.timer.invalidate()
                
                //問題を10問解くごとに（110問まで）、インタースティシャル広告を読み込む
                for x in 1...11 {
                    if (self.solveCount == 10 * x) {
                        // 2.0秒後に実行する処理
                        if self.interstitial.isReady {
                            self.interstitial.present(fromRootViewController: self)
                        } else {
                            print("Ad wasn't ready")
                        }
                    }
                }
                
                self.loadView()
                self.viewDidLoad()
            }
            
        }
        //不正解だった時
        else {
            //print("違いま〜す！（笑）")
            
            // サウンドファイルのパスを生成
            let soundFilePath = Bundle.main.path(forResource: "incorrect1", ofType: "mp3")!
            
            let sound:URL = URL(fileURLWithPath: soundFilePath)
            
            // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
            do {
                audioPlayerInstance2 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
            } catch {
                print("AVAudioPlayerインスタンス作成でエラー")
            }
            // 再生準備
            audioPlayerInstance2.prepareToPlay()
            
            // 再生箇所を頭に移す
            audioPlayerInstance2.currentTime = 0
            // 再生する
            audioPlayerInstance2.play()
            
            inputLabel1.text = ""
            inputLabel2.text = ""
            inputLabel3.text = ""
            inputLabel4.text = ""
            
        }
    }
    
    // ①セグエ実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // ②Segueの識別子確認
        if segue.identifier == "toFirst" {
            
            // ③遷移先ViewCntrollerの取得
            let firstView = segue.destination as! ViewController
            
            // ④値の設定
            firstView.solveCount1 = solveCount
        }
    }
    
    @IBAction func homeButtonAction(_ sender: UIButton) {
        //highscore2 = String(Int(highscore2)! + solveCount)
        performSegue(withIdentifier: "toFirst", sender: nil)
        
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
