//
//  Enemy.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-25.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy : Entity
{
    var dmg = 0
    var ats = 0
    var def = 0
    var evs = 0
    var prs = 0
    var hp = 0
    
    init(x : Int, y : Int, z : Int, s : SKSpriteNode, st : [Int])
    {
        for i in 0...5
        {
            let val = st[i]
            if i == 0
            {
                dmg = val
            }
            else if i == 1
            {
                ats = val
            }
            else if i == 2
            {
                def = val
            }
            else if i == 3
            {
                evs = val
            }
            else if i == 4
            {
                prs = val
            }
            else if i == 5
            {
                hp = val
            }
        }
        super.init(x : x, y : y, z : z, s : s, m : .ENEMY)
    }
}