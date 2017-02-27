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

class setEveningViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    
    let realm = try! Realm()
    var counter:Int = 0
    let motionManager:CMMotionManager = CMMotionManager()
    
    @IBAction func tappedOKButton(_ sender: UIButton) {
        // データを保存して、目標設定完了という画面に
        
        let daily = realm.objects(Daily.self).first
        daily?.evening = counter
        let goal = realm.objects(Goal.self).first
        goal?.daily.append(daily!)
    }
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        countMotion()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        countMotion()
    }
    
    func countMotion () {
        self.counter += 1
        self.countLabel.text = String(self.counter)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
