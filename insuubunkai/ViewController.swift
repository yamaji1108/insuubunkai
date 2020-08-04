//
//  ViewController.swift
//  insuubunkai
//
//  Created by 山田拓也 on 2019/08/01.
//  Copyright © 2019 山田拓也. All rights reserved.
//

// developブランチで編集を加えた。テスト

import UIKit
import GoogleMobileAds
import NCMB

class ViewController: UIViewController {
    
    // 広告ユニットID
    let AdMobID = "ca-app-pub-7071770782912768/9773003969"
    // テスト用広告ユニットID
    let TEST_ID = "ca-app-pub-3940256099942544/2934735716"
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var newrecordLabel: UILabel!    

    @IBOutlet weak var levelSeg: UISegmentedControl!
    
    //ハイスコア管理
    let ud = UserDefaults.standard
    var solveCount1 = 0
    var time1 = 1000
    var username = "user1"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        
        var admobView = GADBannerView()
        admobView = GADBannerView(adSize:kGADAdSizeBanner)
        
        // 広告の位置調整
        admobView.frame.origin = CGPoint(x:self.view.frame.width * 0.1, y:self.view.frame.height - admobView.frame.height - 25)
        admobView.frame.size = CGSize(width:self.view.frame.width * 0.8, height:admobView.frame.height)
        
        //テスト時はTEST_ID、本番時はAdMobIDを使用
        admobView.adUnitID = AdMobID
        
        admobView.rootViewController = self
        admobView.load(GADRequest())
        
        self.view.addSubview(admobView)
        
        //bestrecordの初期値は1000とする
        ud.register(defaults: ["bestrecord": 1000])
        
        //保存済みの情報を取得
        var totalscore = ud.integer(forKey: "totalscore")
        var bestrecord = ud.integer(forKey: "bestrecord")
        
        //元の解いた数に今解いた数を足す
        totalscore = totalscore + solveCount1
        
        //新しいタイムが保持記録よりも短い場合は、それを最高記録とする
//        if (time1 < bestrecord) {
//            bestrecord = time1
//        }
        
        //取得した情報をuserdefaultのインスタンスに格納
        ud.set(totalscore , forKey: "totalscore")
        ud.set(bestrecord , forKey: "bestrecord")
        
        //端末に情報を保存
        ud.synchronize()
        
        //画面にハイスコアを表示
        highscoreLabel.text = "今まで解いた数： " + String(totalscore) + " 問"
        
        //画面にタイムを表示
        if(bestrecord == 1000) {
            newrecordLabel.text = "あなたのTA記録：   秒"
        } else {
            newrecordLabel.text = "あなたのTA記録： " + String(bestrecord) + " 秒"
        }
    }
    
    
    // ①セグエ実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // ②Segueの識別子確認（view2の遷移の時）
        if segue.identifier == "toSecond" {
            // ③遷移先ViewCntrollerの取得
            let secondView = segue.destination as! View2ViewController
            // ④値の設定
            secondView.highscore2 = ud.integer(forKey: "highscore")
            secondView.level = levelSeg.selectedSegmentIndex
        }
        //②Segueの識別子確認（view3の遷移の時）
        else if (segue.identifier == "toThird") {
            // ③遷移先ViewCntrollerの取得
            let thirdView = segue.destination as! View3ViewController
            // ④値の設定
            thirdView.bestrecord = ud.integer(forKey: "bestrecord")
            thirdView.level = levelSeg.selectedSegmentIndex
        }
    }
    
    //STARTボタンを押した時のアクション（view2への遷移）
    @IBAction func startAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toSecond", sender: nil)
    }
    
    //タイムアタックを押した時のアクション（view3への遷移）
    @IBAction func timeattackAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toThird", sender: nil)
        
    }
    
    //ランキングボタンを押した時のアクション（rankingViewへの遷移）
    
    @IBAction func torankingAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toRanking", sender: nil)
    }
    

}

