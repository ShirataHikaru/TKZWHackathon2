//
//  LightScene.swift
//  TKZWHackathon2
//
//  Created by 白田光 on 2017/02/28.
//  Copyright © 2017年 白田光. All rights reserved.
//

import UIKit
import SpriteKit

class LightScene: SKScene {
    
    let kFadeDuration = TimeInterval(1.3)
    
    var lightNode: SKEmitterNode!
    
    let ud = UserDefaults.standard
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        addPaper()
        showPaper()
    }
    
    override func willMove(from view: SKView) {
        lightNode.removeFromParent()
    }
    
    func addPaper(){
        let counter = ud.integer(forKey: "counter")
        let fileName = "Fire"
        let path = Bundle.main.path(forResource: fileName, ofType: "sks")!
        lightNode = NSKeyedUnarchiver.unarchiveObject(withFile: path) as! SKEmitterNode
        lightNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 4)
        lightNode.alpha = 0.5
        lightNode.particleSpeed = CGFloat(counter * 4)
        lightNode.particleSize.width = CGFloat(counter * 4)
        lightNode.particleSize.height = CGFloat(counter * 4)
        addChild(lightNode)
    }
    
    func showPaper(){
        let show = SKAction.fadeIn(withDuration: kFadeDuration)
        lightNode.run(show)
    }
}
