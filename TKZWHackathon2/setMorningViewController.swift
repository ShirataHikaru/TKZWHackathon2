//
//  setMorningViewController.swift
//  TKZWHackathon2
//
//  Created by TaikiFnit on 2017/02/27.
//  Copyright © 2017年 白田光. All rights reserved.
//

import UIKit
import CoreMotion

class setMorningViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    var counter:Int = 0
    let motionManager:CMMotionManager = CMMotionManager()
    
    @IBAction func tappedOKButton(_ sender: UIButton) {
        // データを保存して、目標設定完了という画面に
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        //        self.performSegue(withIdentifier: "toSetGoal", sender: nil)
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
