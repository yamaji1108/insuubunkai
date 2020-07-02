//
//  View3ViewController.swift
//  insuubunkai
//
//  Created by 山田拓也 on 2020/03/08.
//  Copyright © 2020 山田拓也. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation
import GoogleMobileAds

class View3ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,GADInterstitialDelegate {
    
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
    
    @IBOutlet weak var nijisikiImage1: UIImageView!
    
    @IBOutlet weak var nijisikiImage2: UIImageView!
    
    @IBOutlet weak var insuuImage: UIImageView!
    
    @IBOutlet weak var gifImage: UIImageView!
    
    @IBOutlet weak var readyImage: UIImageView!
    
    @IBOutlet weak var startImage: UIImageView!
    
    @IBOutlet weak var sokomadeImage: UIImageView!    
    
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
    var bestrecord = 0
    var level:Int = 0
    
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    var audioPlayerInstance2 : AVAudioPlayer! = nil
    var audioPlayerInstance3 : AVAudioPlayer! = nil
    var audioPlayerInstance4 : AVAudioPlayer! = nil
    var audioPlayerInstance5 : AVAudioPlayer! = nil
    
    
    var leftValue: Int = 0
    var rightValue: Int = 0
    
    var timer = Timer()
    var timeCount = 0
    
    var solveCount:Int = 0
    
    //GADInterstitial型の変数を宣言
    var interstitial: GADInterstitial!
    
    // 広告ユニットID
    let AdMobInID = "ca-app-pub-7071770782912768/1190453008"
    // テスト用広告ユニットID
    let TESTIn_ID = "ca-app-pub-3940256099942544/4411468910"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("levelは" + String(level))
        
        //createAndLoadInterstitialメソッドの呼び出し
        interstitial = createAndLoadInterstitial()
        
        // timer処理
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.timeCount += 1
            self.timeCountLabel.text = "\(self.timeCount)秒"
        })
        
        let layout = UICollectionViewFlowLayout()
        
        //初回読み込み時の処理
        if(solveCount == 0) {
            //timerの一時停止
            self.timer.invalidate()
            
            //レディ男性の登録
            readyImage.image = UIImage(named: "readyman")
            
            // サウンドファイルのパスを生成
            let soundFilePath3 = Bundle.main.path(forResource: "ready-sound", ofType: "mp3")!
            
            let sound3:URL = URL(fileURLWithPath: soundFilePath3)
            
            // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
            do {
                audioPlayerInstance3 = try AVAudioPlayer(contentsOf: sound3, fileTypeHint:nil)
            } catch {
                print("AVAudioPlayerインスタンス作成でエラー")
            }
            
            // 再生準備
            audioPlayerInstance3.prepareToPlay()
            // 再生箇所を頭に移す
            audioPlayerInstance3.currentTime = 0
            // 再生する
            audioPlayerInstance3.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                // 2秒後に実行する処理
                // imageを削除
                self.readyImage.removeFromSuperview()
                //print("前半の処理が読まれたよ")
                
                //開始男性の登録
                self.startImage.image = UIImage(named: "startman")
                
                // サウンドファイルのパスを生成
                let soundFilePath4 = Bundle.main.path(forResource: "start-sound", ofType: "mp3")!
                
                let sound4:URL = URL(fileURLWithPath: soundFilePath4)
                
                // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
                do {
                    self.audioPlayerInstance4 = try AVAudioPlayer(contentsOf: sound4, fileTypeHint:nil)
                } catch {
                    print("AVAudioPlayerインスタンス作成でエラー")
                }
                
                // 再生準備
                self.audioPlayerInstance4.prepareToPlay()
                
                // 再生箇所を頭に移す
                self.audioPlayerInstance4.currentTime = 0
                // 再生する
                self.audioPlayerInstance4.play()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    // 1秒後に実行する処理
                    // imageを削除
                    self.startImage.removeFromSuperview()
                    //print("後半の処理が読まれたよ")
                    
                    // timer処理
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                        self.timeCount += 1
                        self.timeCountLabel.text = "\(self.timeCount)秒"
                    })
                }
            }
        }
        //ここまで初回読み込み時の処理
        
        
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
                
//                //問題を10問解くごとに（110問まで）、インタースティシャル広告を読み込む
//                for x in 1...11 {
//                    if (self.solveCount == 10 * x) {
//                        // 2.0秒後に実行する処理
//                        if self.interstitial.isReady {
//                            self.interstitial.present(fromRootViewController: self)
//                        } else {
//                            print("Ad wasn't ready")
//                        }
//                    }
//                }
                
                //10問解き終わったら終了
                if (self.solveCount == 10) {
                    //終了男性の登録
                    self.sokomadeImage.image = UIImage(named: "sokomade")
                    
                    // サウンドファイルのパスを生成
                    let soundFilePath5 = Bundle.main.path(forResource: "end-sound", ofType: "mp3")!
                    
                    let sound5:URL = URL(fileURLWithPath: soundFilePath5)
                    
                    // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
                    do {
                        self.audioPlayerInstance5 = try AVAudioPlayer(contentsOf: sound5, fileTypeHint:nil)
                    } catch {
                        print("AVAudioPlayerインスタンス作成でエラー")
                    }
                    
                    // 再生準備
                    self.audioPlayerInstance5.prepareToPlay()
                    // 再生箇所を頭に移す
                    self.audioPlayerInstance5.currentTime = 0
                    // 再生する
                    self.audioPlayerInstance5.play()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        // 1.5秒後に実行する処理
                        // imageを削除
                        self.sokomadeImage.removeFromSuperview()
                        
//                        //インターステイシャル広告の読み込み
//                        if self.interstitial.isReady {
//                            self.interstitial.present(fromRootViewController: self)
//                        } else {
//                            print("Ad wasn't ready")
//                        }
                        
                        //結果画面に遷移
                        self.performSegue(withIdentifier: "toResult", sender: nil)
                        
                    }
                    
                } else {
                    self.loadView()
                    self.viewDidLoad()
                }
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
        if segue.identifier == "toResult" {
            let resultView = segue.destination as! ResultViewController
            
            resultView.solveCount = self.solveCount
            resultView.timeInt = self.timeCount
            resultView.bestrecord = self.bestrecord
            resultView.level = self.level
        }
    }
    
    @IBAction func homeButtonAction(_ sender: UIButton) {
        //highscore2 = String(Int(highscore2)! + solveCount)
        performSegue(withIdentifier: "fromThirdtoFirst", sender: nil)
        
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
