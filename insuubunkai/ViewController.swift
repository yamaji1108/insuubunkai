//
//  ViewController.swift
//  insuubunkai
//
//  Created by 山田拓也 on 2019/08/01.
//  Copyright © 2019 山田拓也. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    
    // 広告ユニットID
    let AdMobID = "ca-app-pub-7071770782912768/9773003969"
    // テスト用広告ユニットID
    let TEST_ID = "ca-app-pub-3940256099942544/2934735716"
    
    @IBOutlet weak var startButton: UIButton!
    
    
    //ハイスコア管理
    let ud = UserDefaults.standard
    var highscore1 : String = ""
    
    @IBOutlet weak var highscoreLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        
        var admobView = GADBannerView()
        
        admobView = GADBannerView(adSize:kGADAdSizeBanner)
        
        // 広告の位置調整
        admobView.frame.origin = CGPoint(x:self.view.frame.width * 0.1, y:self.view.frame.size.height - admobView.frame.height - 40)
        admobView.frame.size = CGSize(width:self.view.frame.width * 0.8, height:admobView.frame.height)
        
        //テスト時はTEST_ID、本番時はAdMobIDを使用
        admobView.adUnitID = TEST_ID
        
        admobView.rootViewController = self
        admobView.load(GADRequest())
        
        //ハイスコアはいったん0に
        ud.set( "0" , forKey: "highscore")
        
        self.view.addSubview(admobView)
        
        highscore1 = (ud.object(forKey: "highscore") as? String)!
        
        highscoreLabel.text = "あなたのハイスコア：" + highscore1 + "問"
        
    }
    
    
    // ①セグエ実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // ②Segueの識別子確認
        if segue.identifier == "toSecond" {

            // ③遷移先ViewCntrollerの取得
            let secondView = segue.destination as! View2ViewController

            // ④値の設定
            secondView.highscore2 = ud.object(forKey: "highscore") as! String
        }
    }
    
    @IBAction func startAction(_ sender: UIButton) {

        performSegue(withIdentifier: "toSecond", sender: nil)

    }
    
    
    

}

