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
    var movSpeed = 2
    var isAlive = true
    var isDespawned = false
    var inCombat = false
    
    var name : String
    var direction = Direction.LEFT
    
    var player : Player?
    
    init(x : Int, y : Int, z : Int, s : SKSpriteNode, st : [Int], str : String)
    {
        
        name = str
        
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
        if !inCombat
        {
            if direction == .LEFT
            {
                self.pos.x -= movSpeed
            }
            if direction == .RIGHT
            {
                self.pos.x += movSpeed
            }
            if direction == .UP
            {
                self.pos.y += movSpeed
            }
            if direction == .DOWN
            {
                self.pos.y -= movSpeed
            }
        }
        
        
        if hp <= 0
        {
            isAlive = false
        }
        
        sprite!.position.x = CGFloat(pos.x)
        sprite!.position.y = CGFloat(pos.y)
    }
    
    override func collision(response : Entity)
    {
        if response.collisionMask == .WORLD
        {
            let a = self.sprite!
            let aBottom = self.pos.y - Int(a.frame.height / 2)
            let aTop = self.pos.y - Int(a.frame.height / 3)
            let aLeft = self.pos.x - Int(a.frame.width / 8)
            let aRight = self.pos.x + Int(a.frame.width / 8)
            
            let aPos = Pos(xX : Int(a.position.x), yY : aBottom + Int(a.frame.height / 4))
            
            var bBottom : Int
            var bTop : Int
            var bLeft : Int
            var bRight : Int
            if let b = response.sprite
            {
                bBottom = response.pos.y - Int(b.frame.height / 2)
                bTop = response.pos.y + Int(b.frame.height / 2)
                bLeft = response.pos.x - Int(b.frame.width / 2)
                bRight = response.pos.x + Int(b.frame.width / 2)
            }
            else
            {
                bBottom = response.pos.y - (response.height! / 2)
                bTop = response.pos.y + (response.height! / 2)
                bLeft = response.pos.x - (response.width! / 2)
                bRight = response.pos.x + (response.width! / 2)
            }
        
            if aBottom <= bTop &&
                aTop >= bBottom &&
                aLeft <= bRight &&
                aRight >= bLeft
            {
                if direction == .UP
                {
                    aPos.y -= aTop - (bBottom - 1)
                    direction = .DOWN
                }
                else if direction == .DOWN
                {
                    aPos.y += bTop - (aBottom - 1)
                    direction = .UP
                }
                if direction == .RIGHT
                {
                    aPos.x -= aRight - (bLeft - 1)
                    direction = .LEFT
                }
                else if direction == .LEFT
                {
                    aPos.x += bRight - (aLeft - 1)
                    direction = .RIGHT
                }
            }
            
            sprite!.position.x = CGFloat(pos.x)
            sprite!.position.y = CGFloat(pos.y)
        }
    }
}
