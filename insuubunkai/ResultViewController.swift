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

class ResultViewController: UIViewController {
    
    @IBOutlet weak var yourtimeisLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var idregisterLabel: UILabel!
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var newrecordView: UIImageView!
    
    @IBOutlet weak var idtextConstraint: NSLayoutConstraint!
    @IBOutlet weak var registerbuttonConstraint: NSLayoutConstraint!
    
    var solveCount = 0
    var timeInt = 0
    var bestrecord = 0
    var audioPlayerInstance1 : AVAudioPlayer! = nil
    var level = 0
    var levelstr = ""
    
    let ud = UserDefaults.standard
    
    //オブジェクトの作成
    let object : NCMBObject = NCMBObject(className: "record")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //難易度設定
        if (level == 0) {
            levelstr = "NORMAL"
        } else if (level == 1) {
            levelstr = "HARD"
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
                    
                    self.idregisterLabel.text = "IDを登録する"
                    self.idtextConstraint.constant = 55
                    self.registerbuttonConstraint.constant = 115
                }
                
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
            firstView.solveCount1 = solveCount
        }
    }
    
    //homeへ戻るボタンを押した時の処理
    @IBAction func toHomeAction(_ sender: UIButton) {
        performSegue(withIdentifier: "fromResulttoFirst", sender: nil)
        
    }
    
    
    @IBAction func registerAction(_ sender: UIButton) {
        let iddate = idText.text
        
        // オブジェクトに値を設定
        object.setObject(iddate, forKey: "username")
        object.setObject(bestrecord, forKey: "bestrecord")
        object.setObject(levelstr, forKey: "level")
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
