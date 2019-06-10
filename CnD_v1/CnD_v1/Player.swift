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
    
    init (x : Int, y : Int, w : Int, h : Int, s : SKSpriteNode)
    {
        //left = Button()
        
        super.init(x : x, y : y, w : w, h : h, s : s, m : .PLAYER)
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
        let aBottom = self.pos.y - (self.height / 2)
        let aTop = self.pos.y + (self.height / 2)
        let aLeft = self.pos.x - (self.width / 2)
        let aRight = self.pos.x + (self.width / 2)
        let bBottom = response.pos.y - (response.height / 2)
        let bTop = response.pos.y + (response.height / 2)
        let bLeft = response.pos.x - (response.width / 2)
        let bRight = response.pos.x + (response.width / 2)
        
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
                        pos.y = aBottom - (aTop - (bBottom - 1)) - (height / 2)
                    }
                    else
                    {
                        pos.y = bTop + (height / 2)
                    }
                }
                else if diffX > diffY
                {
                    if pos.x < response.pos.x
                    {
                        pos.x = aLeft - (aRight - bLeft) - (width / 2)
                    }
                    else
                    {
                        pos.x = bRight + (width / 2) + 1
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
