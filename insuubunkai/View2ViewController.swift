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

class View2ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var indicateLabel1: UILabel!
    
    @IBOutlet weak var indicateLabel2: UILabel!
    
    @IBOutlet weak var inputLabel1: UILabel!
    
    @IBOutlet weak var inputLabel2: UILabel!
    
    @IBOutlet weak var inputLabel3: UILabel!
    
    @IBOutlet weak var inputLabel4: UILabel!
    
    @IBOutlet weak var timeCountLabel: UILabel!
    
    @IBOutlet weak var solveNumberLabel: UILabel!
    
    @IBOutlet weak var CollectionView1: UICollectionView!
    
    @IBOutlet weak var nijisikiImage1: UIImageView!
    
    @IBOutlet weak var insuuImage: UIImageView!
    
    @IBOutlet weak var gifImage: UIImageView!
    
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    var audioPlayerInstance2 : AVAudioPlayer! = nil
    
    var leftValue: Int = 0
    var rightValue: Int = 0
    
    var timer = Timer()
    var timeCount = 0
    
    var solveCount:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // timer処理
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.timeCount += 1
            //self.timeCount値をtimeCountLabelに代入
            self.timeCountLabel.text = "\(self.timeCount)秒"
        })
        
        // 解いた数の表示
        solveNumberLabel.text = ""
        
        if(solveCount != 0) {
            solveNumberLabel.text = "\(solveCount)問"
        }
        
        // バンドルした画像ファイルを読み込んで、nijisikiImage1に画像を設定
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
        
        if (ran1 == ran2) {
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

        
        return cell
    }
    

    
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
    
    @IBAction func enterButton(_ sender: UIButton) {
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
        
        if(leftValue + rightValue == a)&&(leftValue * rightValue == b) {
            //print("正解だよ！")
            
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

            
            let seikaiImage = UIImage(named: "丸（透過）")
            gifImage.image = seikaiImage
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // 2秒後に実行する処理
                // imageを削除
                self.gifImage.removeFromSuperview()
                
                // timerの一時停止
                self.timer.invalidate()
                
                self.loadView()
                self.viewDidLoad()
                
            }
            
            solveCount = solveCount + 1
            
            //let url = URL(string:"https://www.doyo-juku.com/kentei/answer/img/y.gif")!
            
            //let animationGifView = WKWebView(frame: CGRect(x:0,y:0,width:300,height:400))
            
            //animationGifView.center = CGPoint(x:self.view.frame.width / 2.0,y:self.view.frame.height * 2 / 7.0)
            
            //urlをNSDataに変換
            //let gifData =  NSData(contentsOf: url)
            
            //gifをloadする
            
            //animationGifView.load(URLRequest(url: url))
            //self.view.addSubview(animationGifView)
            
            
            
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
