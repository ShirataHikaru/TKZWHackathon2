//
//  Daily.swift
//  TKZWHackathon2
//
//  Created by 白田光 on 2017/02/27.
//  Copyright © 2017年 白田光. All rights reserved.
//

import Foundation
import RealmSwift


class Daily: Object {
    dynamic var id = Int()
    dynamic var morning = Int()
    dynamic var evening = Int()
    dynamic var createdAt = Date()
    dynamic var goal:Goal?
}
