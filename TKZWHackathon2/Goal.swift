//
//  Goal.swift
//  TKZWHackathon2
//
//  Created by 白田光 on 2017/02/27.
//  Copyright © 2017年 白田光. All rights reserved.
//

import Foundation
import RealmSwift

class Goal: Object {
    dynamic var name = String()
    dynamic var limit = Date()
    dynamic var timeStamp = Date()
    let daily = List<Daily>()
    
}
