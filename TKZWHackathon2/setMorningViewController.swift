//
//  setMorningViewController.swift
//  TKZWHackathon2
//
//  Created by TaikiFnit on 2017/02/27.
//  Copyright © 2017年 白田光. All rights reserved.
//

import UIKit
import CoreMotion
import RealmSwift
import SpriteKit

class setMorningViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var skView: SKView!
    
    
    let realm = try! Realm()
    var counter:Int = 0
    let motionManager:CMMotionManager = CMMotionManager()
    var isEnableMoring:Bool = true
    
    @IBAction func tappedOKButton(_ sender: UIButton) {
        // データを保存して、目標設定完了という画面に
        
        let daily = Daily()
        daily.morning = counter
        daily.createdAt = Date()
        daily.done = false
//
        let goal = realm.objects(Goal.self).filter("done == 0").first
        try! realm.write() {
            goal?.daily.append(daily)
        }
        checkDone()
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if isEnableMoring == true {
            countMotion()
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if isEnableMoring == true {
            countMotion()
        }
    }
    
    func countMotion () {
        self.counter += 1
        self.countLabel.text = String(self.counter)
        let ud = UserDefaults.standard
        ud.set(self.counter, forKey: "counter")
        self.showParticle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let goal = realm.objects(Goal.self).filter("done == 0").first
        print(goal)
        if goal == nil {
            // 0じゃないgoalがない = 目標がまだ設定されていない. So, move 目標設定画面
            self.performSegue(withIdentifier: "toSetGoal", sender: nil)
        }
        let ud = UserDefaults.standard
        ud.set(0, forKey: "counter")

        checkDone()
    }
    
    func checkDone() {
        let daily = realm.objects(Daily.self).filter("done == 0").first
        
        // eveningがzeroのdailyがある = morningのcounterはset済み
        if let d = daily {
            self.isEnableMoring = false
            self.okButton.isEnabled = false
            self.countLabel.text = String(d.morning)
            self.titleLabel.text = "設定したやる気"
        }
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
