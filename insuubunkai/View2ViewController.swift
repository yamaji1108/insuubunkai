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
    
    
    @IBOutlet weak var indicateLabel1: UILabel!
    
    @IBOutlet weak var indicateLabel2: UILabel!
    
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
    
    @IBOutlet weak var nijisikiImage1: UIImageView!
    
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
            layout.minimumLineSpacing = 20
            let cellWidth = floor(CollectionView1.bounds.width * 0.26)
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            CollectionView1.collectionViewLayout = layout
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            // 使用デバイスがiPadの場合
            // collectionの制約を変更
            let myAppBoundSize: CGSize = UIScreen.main.bounds.size
            leftConstraint.constant = myAppBoundSize.width * 0.35
            bottomConstraint.constant = myAppBoundSize.height * 0.25
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
        
        // バンドルした画像ファイルを読み込んで、二次式と因数用の画像を設定
        let image1 = UIImage(named: "二次式")
        nijisikiImage1.image = image1

        let image2 = UIImage(named: "因数分解")
        insuuImage.image = image2
        
        inputLabel1.text = ""
        inputLabel2.text = ""
        inputLabel3.text = ""
        inputLabel4.text = ""
        
        let array: [Int] = [-9,-8,-7,-6,-5,-4,-3,-2,-1,1,2,3,4,5,6,7,8,9]
        
        let ran1 = array.randomElement()!
        var ran2 = array.randomElement()!
        
        if (ran1 == 9) && (ran2 == 9) {
            ran2 = ran2 - 1
        } else if (ran1 == -9) && (ran2 == 9) {
            ran2 = ran2 - 1
        } else if (ran1 == 1) && (ran2 == -1) {
            ran2 = ran2 - 1
        } else if (ran1 == ran2) {
            ran2 = ran2 + 1
        } else if (ran1 == ran2 * (-1)) {
            ran2 = ran2 + 1
        }
        
        let indicateValue1 = ran1 + ran2
        let indicateValue2 = ran1 * ran2
        
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
    
    //インタースティシャル広告を読み込む
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: TESTIn_ID)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    //インタースティシャル広告の初期化
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        createAndLoadInterstitial()
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
            cellLabel1.text = "1"
        } else if (String(indexPath.row) == "1") {
            cellLabel1.text = "2"
        } else if (String(indexPath.row) == "2") {
            cellLabel1.text = "3"
        } else if (String(indexPath.row) == "3") {
            cellLabel1.text = "4"
        } else if (String(indexPath.row) == "4") {
            cellLabel1.text = "5"
        } else if (String(indexPath.row) == "5") {
            cellLabel1.text = "6"
        } else if (String(indexPath.row) == "6") {
            cellLabel1.text = "7"
        } else if (String(indexPath.row) == "7") {
            cellLabel1.text = "8"
        } else if (String(indexPath.row) == "8") {
            cellLabel1.text = "9"
        } else if (String(indexPath.row) == "9") {
            cellLabel1.text = "-"
        } else if (String(indexPath.row) == "10") {
            cellLabel1.text = "0"
        } else if (String(indexPath.row) == "11") {
            cellLabel1.text = "+"
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
                inputLabel1.text = "-"
            } else if (String(indexPath.row) == "10") {
                inputLabel1.text = ""
            } else if (String(indexPath.row) == "11") {
                inputLabel1.text = "+"
            }
        } else if (inputLabel2.text == "") {
            if (String(indexPath.row) == "0") {
                inputLabel2.text = "1"
            } else if (String(indexPath.row) == "1") {
                inputLabel2.text = "2"
            } else if (String(indexPath.row) == "2") {
                inputLabel2.text = "3"
            } else if (String(indexPath.row) == "3") {
                inputLabel2.text = "4"
            } else if (String(indexPath.row) == "4") {
                inputLabel2.text = "5"
            } else if (String(indexPath.row) == "5") {
                inputLabel2.text = "6"
            } else if (String(indexPath.row) == "6") {
                inputLabel2.text = "7"
            } else if (String(indexPath.row) == "7") {
                inputLabel2.text = "8"
            } else if (String(indexPath.row) == "8") {
                inputLabel2.text = "9"
            } else if (String(indexPath.row) == "9") {
                inputLabel2.text = ""
            } else if (String(indexPath.row) == "10") {
                inputLabel2.text = "0"
            } else if (String(indexPath.row) == "11") {
                inputLabel2.text = ""
            }
        } else if (inputLabel3.text == "") {
            if (String(indexPath.row) == "0") {
                inputLabel3.text = ""
            } else if (String(indexPath.row) == "1") {
                inputLabel3.text = ""
            } else if (String(indexPath.row) == "2") {
                inputLabel3.text = ""
            } else if (String(indexPath.row) == "3") {
                inputLabel3.text = ""
            } else if (String(indexPath.row) == "4") {
                inputLabel3.text = ""
            } else if (String(indexPath.row) == "5") {
                inputLabel3.text = ""
            } else if (String(indexPath.row) == "6") {
                inputLabel3.text = ""
            } else if (String(indexPath.row) == "7") {
                inputLabel3.text = ""
            } else if (String(indexPath.row) == "8") {
                inputLabel3.text = ""
            } else if (String(indexPath.row) == "9") {
                inputLabel3.text = "-"
            } else if (String(indexPath.row) == "10") {
                inputLabel3.text = ""
            } else if (String(indexPath.row) == "11") {
                inputLabel3.text = "+"
            }
        } else {
            if (String(indexPath.row) == "0") {
                inputLabel4.text = "1"
            } else if (String(indexPath.row) == "1") {
                inputLabel4.text = "2"
            } else if (String(indexPath.row) == "2") {
                inputLabel4.text = "3"
            } else if (String(indexPath.row) == "3") {
                inputLabel4.text = "4"
            } else if (String(indexPath.row) == "4") {
                inputLabel4.text = "5"
            } else if (String(indexPath.row) == "5") {
                inputLabel4.text = "6"
            } else if (String(indexPath.row) == "6") {
                inputLabel4.text = "7"
            } else if (String(indexPath.row) == "7") {
                inputLabel4.text = "8"
            } else if (String(indexPath.row) == "8") {
                inputLabel4.text = "9"
            } else if (String(indexPath.row) == "9") {
                inputLabel4.text = ""
            } else if (String(indexPath.row) == "10") {
                inputLabel4.text = "0"
            } else if (String(indexPath.row) == "11") {
                inputLabel4.text = ""
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
        
        if(indicateLabel1.text == "+") {
            a = 1
        } else if (indicateLabel1.text == "-") {
            a = -1
        } else {
            a = Int(indicateLabel1.text ?? "0")!
        }
        
        b = Int(indicateLabel2.text ?? "0")!
        
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
            
        } else {
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
