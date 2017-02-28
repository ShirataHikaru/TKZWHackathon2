//
//  SetGoalViewController.swift
//  TKZWHackathon2
//
//  Created by TaikiFnit on 2017/02/27.
//  Copyright © 2017年 白田光. All rights reserved.
//

import UIKit
import RealmSwift

class SetGoalViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func TappedSubmitButton(_ sender: UIButton) {
        let goal = Goal()
        if myTextField.text != "" {
            goal.name = myTextField.text!
            goal.limit = myDatePicker.date
            goal.done = false
            goal.timeStamp = Date()
            try! realm.write() {
                realm.add(goal)
                self.dismiss(animated: true, completion: nil)
            }
        }else{
        
        }
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
