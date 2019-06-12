//
//  Player.swift
//  CnD
//
//  Created by Gavin McGuire on 2019-06-03.
//  Copyright © 2019 trios. All rights reserved.
//

import Foundation
import SpriteKit


class Player : Entity
{
    var left : Button
    var right : Button
    var up : Button
    var down : Button
    
    var interact : Button
    
    init (x : Int, y : Int, s : SKSpriteNode)
    {
        //left = Button()
        
        super.init(x : x, y : y, s : s, m : .PLAYER)
    }
    
    override func update()
    {
        left.update()
        right.update()
        up.update()
        down.update()
        interact.update()
        
        if left.active
        {
            
        }
        if right.active
        {
            
        }
        if up.active
        {
            
        }
        if down.active
        {
            
        }
        if interact.active
        {
            
        }
        
    }
    
    override func collision(response : Entity)
    {
        let aBottom = self.pos.y - Int(self.sprite.size.height / 2)
        let aTop = self.pos.y + Int(self.sprite.size.height / 2)
        let aLeft = self.pos.x - Int(self.sprite.size.width / 2)
        let aRight = self.pos.x + Int(self.sprite.size.width / 2)
        let bBottom = response.pos.y - Int(response.sprite.size.height / 2)
        let bTop = response.pos.y + Int(response.sprite.size.height / 2)
        let bLeft = response.pos.x - Int(response.sprite.size.width / 2)
        let bRight = response.pos.x + Int(response.sprite.size.width / 2)
        
        var diffX = 0
        var diffY = 0
        
        if aTop < response.pos.y
        {
            diffY = bBottom - aTop
        }
        else if aBottom > response.pos.y
        {
            diffY = aBottom - bTop
        }
        
        if aRight < response.pos.y
        {
            diffX = bLeft - aRight
        }
        else if aLeft > response.pos.y
        {
            diffX = aLeft - bRight
        }
        
        if aBottom <= bTop &&
        aTop >= bBottom &&
        aLeft <= bRight &&
        aRight >= bLeft
        {
            if response.collisionMask == .INTERACTABLE
            {
                interact.interactable = (response as! Interactable)
            }
            else if response.collisionMask == .WORLD
            {
                if diffX < diffY
                {
                    if pos.y < response.pos.y
                    {
                        pos.y = aBottom - (aTop - (bBottom - 1)) - Int(sprite.size.height / 2)
                    }
                    else
                    {
                        pos.y = bTop + Int(sprite.size.height / 2)
                    }
                }
                else if diffX > diffY
                {
                    if pos.x < response.pos.x
                    {
                        pos.x = aLeft - (aRight - bLeft) - Int(sprite.size.width / 2)
                    }
                    else
                    {
                        pos.x = bRight + Int(sprite.size.width / 2) + 1
                    }
                }
            }
        }
        else if interact.interactable == response
        {
            interact.interactable = nil
        }
    }
}
