//
//  ResultViewController.swift
//  insuubunkai
//
//  Created by 山田拓也 on 2020/03/08.
//  Copyright © 2020 山田拓也. All rights reserved.
//

import UIKit
import AVFoundation
import NCMB
import GoogleMobileAds

class ResultViewController: UIViewController, GADInterstitialDelegate {
    
    @IBOutlet weak var yourtimeisLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var idregisterLabel: UILabel!
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var newrecordView: UIImageView!
    
    @IBOutlet weak var idtextConstraint: NSLayoutConstraint!
    @IBOutlet weak var registerbuttonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var idtextLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var idtextRigftConstraint: NSLayoutConstraint!
    
    
    var solveCount = 0
    var timeInt = 0
    var bestrecord = 0
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    var level = 0
    var levelstr = ""
    
    let ud = UserDefaults.standard
    //オブジェクトの作成
    let object : NCMBObject = NCMBObject(className: "record")
    
    //GADInterstitial型の変数を宣言
    var interstitial: GADInterstitial!
    // 広告ユニットID
    let AdMobInID = "ca-app-pub-7071770782912768/1190453008"
    // テスト用広告ユニットID
    let TESTIn_ID = "ca-app-pub-3940256099942544/4411468910"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //createAndLoadInterstitialメソッドの呼び出し
        interstitial = createAndLoadInterstitial()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // 使用デバイスがiPadの場合
            // collectionの制約を変更
            idtextLeftConstraint.constant = 360
            idtextRigftConstraint.constant = 360
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // 1秒後に実行する処理
            self.yourtimeisLabel.text = "あなたのタイムは…"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // 1.5秒後に実行する処理
                self.timeLabel.text = String(self.timeInt) + "秒"
                
                //新しいタイムが保持記録よりも短い場合は、それを最高記録とする
                if (self.timeInt < self.bestrecord) {
                    self.newrecordView.image = UIImage(named: "newrecord")
                    self.bestrecord = self.timeInt
                    
                    //取得した情報をuserdefaultのインスタンスに格納
                    self.ud.set(self.bestrecord , forKey: "bestrecord")
                }
                
                self.idregisterLabel.text = "IDを登録する"
                self.idtextConstraint.constant = 55
                self.registerbuttonConstraint.constant = 55
                
                // サウンドファイルのパスを生成
                let soundFilePath1 = Bundle.main.path(forResource: "kansei", ofType: "mp3")!              
                let sound1:URL = URL(fileURLWithPath: soundFilePath1)
                
                // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
                do {
                    self.audioPlayerInstance1 = try AVAudioPlayer(contentsOf: sound1, fileTypeHint:nil)
                } catch {
                    print("AVAudioPlayerインスタンス作成でエラー")
                }
                
                // 再生準備
                self.audioPlayerInstance1.prepareToPlay()
                // 再生箇所を頭に移す
                self.audioPlayerInstance1.currentTime = 0
                // 再生する
                self.audioPlayerInstance1.play()
                
                //1.5秒後にインタースティシャル広告の読み込み
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    if self.interstitial.isReady {
                        self.interstitial.present(fromRootViewController: self)
                    } else {
                        print("Ad wasn't ready")
                    }
                }
            }
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
    
    // ①セグエ実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // ②Segueの識別子確認
        if segue.identifier == "fromResulttoFirst" {
            
            // ③遷移先ViewCntrollerの取得
            let firstView = segue.destination as! ViewController
            
            // ④値の設定
            firstView.time1 = timeInt
            firstView.solveCount1 = solveCount
        }
    }
    
    //homeへ戻るボタンを押した時の処理
    @IBAction func toHomeAction(_ sender: UIButton) {
        performSegue(withIdentifier: "fromResulttoFirst", sender: nil)
        
    }
    
    
    @IBAction func registerAction(_ sender: UIButton) {
        if(idText.text == "") {
            idText.text = "無名"
        }
        let iddate = idText.text
        
        // オブジェクトに値を設定
        object.setObject(iddate, forKey: "username")
        object.setObject(bestrecord, forKey: "bestrecord")
        object.setObject(level, forKey: "level")
        // データストアへの登録を実施
        object.saveInBackground({ (error) in
            if error != nil {
                // 保存に失敗した場合の処理
                print("失敗したで")
            }else{
                // 保存に成功した場合の処理
                print("成功したで")
                //HOME画面に遷移
                self.performSegue(withIdentifier: "fromResulttoFirst", sender: nil)
            }
        })
        
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
