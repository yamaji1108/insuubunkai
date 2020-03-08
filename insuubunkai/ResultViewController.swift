//
//  ResultViewController.swift
//  insuubunkai
//
//  Created by 山田拓也 on 2020/03/08.
//  Copyright © 2020 山田拓也. All rights reserved.
//

import UIKit
import AVFoundation

class ResultViewController: UIViewController {
    
    @IBOutlet weak var yourtimeisLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timeInt = 0
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // 1秒後に実行する処理
            self.yourtimeisLabel.text = "あなたのタイムは…"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // 1.5秒後に実行する処理
                self.timeLabel.text = String(self.timeInt) + "秒"
                
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
                
            }
            
        }
        
    }
    
    // ①セグエ実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // ②Segueの識別子確認
        if segue.identifier == "fromResulttoFirst" {
            
            // ③遷移先ViewCntrollerの取得
            let firstView = segue.destination as! ViewController
            
            // ④値の設定
            firstView.time1 = timeInt
        }
    }
    
    //homeへ戻るボタンを押した時の処理
    @IBAction func toHomeAction(_ sender: UIButton) {
        performSegue(withIdentifier: "fromResulttoFirst", sender: nil)
        
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