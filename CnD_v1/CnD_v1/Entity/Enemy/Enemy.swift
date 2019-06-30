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
    var isAlive = true
    var inCombat = false
    
    var player : Player?
    
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
    
    override func update()
    {
        if hp <= 0
        {
            isAlive = false
            
        }
        if isAlive && inCombat
        {
            let atkCD = player!.combatTimer % ats
            if atkCD == 0
            {
                if arc4random_uniform( (UInt32(50))) > player!.calcTotalEVS() / prs
                {
                    player!.dmgTaken += dmg / player!.calcTotalDEF()
                }
            }
        }
    }
}
