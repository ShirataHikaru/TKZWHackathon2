//
//  setEveningViewController.swift
//  TKZWHackathon2
//
//  Created by TaikiFnit on 2017/02/27.
//  Copyright © 2017年 白田光. All rights reserved.
//

import UIKit
import CoreMotion
import RealmSwift
import AudioToolbox
import SpriteKit

class setEveningViewController: UIViewController {
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var skView: SKView!
    
    let realm = try! Realm()
    var counter:Int = 0
    var isEnableEvening: Bool = true
    let motionManager:CMMotionManager = CMMotionManager()
    
    @IBAction func tappedOKButton(_ sender: UIButton) {
        // データを保存して、目標設定完了という画面に
        
        // 現在進行中のdaily取得
        let daily = realm.objects(Daily.self).filter("done == 0").first
        
        // Dailyに入力されたEveningをSet
        try! realm.write() {
            daily?.evening = counter
            daily?.done = true
            counter = 0
            checkNotDone()
        }
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (isEnableEvening == true) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            countMotion()
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (isEnableEvening == true) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            countMotion()
        }
    }
    
    func countMotion () {
        self.counter += 1
        let ud = UserDefaults.standard
        ud.set(self.counter, forKey: "counter")
        self.showParticle()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkNotDone() {
        let daily = realm.objects(Daily.self).filter("done == 0").first
        
        // done == 0が存在する = 朝はすでに設定されているので夜も設定する
        if let d = daily {
            self.isEnableEvening = true
            self.okButton.isEnabled = true

        } else {
            // done == 0が存在しない = 朝がまだされていないので夜も設定させない
            self.isEnableEvening = false
            self.okButton.isEnabled = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkNotDone()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showParticle()
    }
    
    func showParticle() {
        let scene = LightScene(size: skView.frame.size)
        skView.ignoresSiblingOrder = true
        skView.allowsTransparency = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
