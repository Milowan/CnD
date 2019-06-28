//
//  Boss.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-28.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Boss : Enemy
{
    var specialDamage = 0
    var specialATS = 0
    
    override init(x : Int, y : Int, z : Int, s : SKSpriteNode, st : [Int])
    {
        specialDamage = st[6]
        specialATS = st[7]
        super.init(x : x, y : y, z : z, s : s, st : st)
    }
}
