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
    
    // true:テスト false:本番
    let AdMobTest:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        
        var admobView = GADBannerView()
        
        admobView = GADBannerView(adSize:kGADAdSizeBanner)
        
        // 広告の位置調整
        admobView.frame.origin = CGPoint(x:self.view.frame.width * 0.1, y:self.view.frame.size.height - admobView.frame.height - 40)
        admobView.frame.size = CGSize(width:self.view.frame.width * 0.8, height:admobView.frame.height)
        
        
        if AdMobTest {
            admobView.adUnitID = TEST_ID
        }
        else{
            admobView.adUnitID = AdMobID
        }
        
        admobView.rootViewController = self
        admobView.load(GADRequest())
        
        self.view.addSubview(admobView)
        
    }


}

