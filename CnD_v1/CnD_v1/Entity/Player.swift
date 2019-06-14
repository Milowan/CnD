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

   // var left : Button
   // var right : Button
   // var up : Button
   // var down : Button

   // var interact : Button
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("Use init()")
    }

    
   init (x : Int, y : Int, z : Int, s : SKSpriteNode)
   {
//        left = Button(x: 0,y: 0,z: 5, s: SKSpriteNode(imageNamed: "arrow_left"))
//        s.addChild(left.sprite as! SKSpriteNode)
//        right = Button(x: 0,y: 0,z: 5, s: SKSpriteNode(imageNamed: "arrow_right"))
//        s.addChild(right.sprite as! SKSpriteNode)
//        up = Button(x: 0,y: 0,z: 5, s: SKSpriteNode(imageNamed: "arrow_up"))
//        s.addChild(up.sprite as! SKSpriteNode)
//        down = Button(x: 0,y: 0,z: 5, s: SKSpriteNode(imageNamed: "arrow_down"))
//        s.addChild(down.sprite as! SKSpriteNode)
//        
//        interact = Button(x: 0,y: 0,z: 5, s: SKSpriteNode(imageNamed: "arrow_interact"))
//        s.addChild(interact.sprite as! SKSpriteNode)
        super.init(x : x, y : y, z: z, s : s, m : .PLAYER)
    }
//    
//    override func update()
//    {
//        updateCamera(player: self.sprite as! SKNode)
//        
//        left.update()
//        right.update()
//        up.update()
//        down.update()
//        interact.update()
//
//        if left.active
//        {
//
//        }
//        if right.active
//        {
//
//        }
//        if up.active
//        {
//
//        }
//        if down.active
//        {
//
//        }
//        if interact.active
//        {
//
//        }
//
//    }

    override func collision(response : Entity)
    {
        
        let a = self.sprite as! SKSpriteNode
        var aPos : Pos
        if let pos = self.pos as! Pos?
        {
            aPos = pos
        }
        else
        {
            aPos = Pos(xX : Int(a.position.x), yY : Int(a.position.y), zZ : Int(a.zPosition))
        }
        let aBottom = aPos.y - Int(a.size.height / 2)
        let aTop = aPos.y + Int(a.size.height / 2)
        let aLeft = aPos.x - Int(a.size.width / 2)
        let aRight = aPos.x + Int(a.size.width / 2)
        
        let b = response.sprite as! SKSpriteNode
        var bPos : Pos
        if let pos = response.pos as! Pos?
        {
            bPos = pos
        }
        else
        {
            bPos = Pos(xX : Int(b.position.x), yY : Int(b.position.y), zZ : Int(b.zPosition))
        }
        let bBottom = bPos.y - Int(b.size.height / 2)
        let bTop = bPos.y + Int(b.size.height / 2)
        let bLeft = bPos.x - Int(b.size.width / 2)
        let bRight = bPos.x + Int(b.size.width / 2)
        
        var diffX = 0
        var diffY = 0
        
        if aTop < bPos.y
        {
            diffY = bBottom - aTop
        }
        else if aBottom > bPos.y
        {
            diffY = aBottom - bTop
        }
        
        if aRight < bPos.y
        {
            diffX = bLeft - aRight
        }
        else if aLeft > bPos.y
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
                //interact.interactable = (response as! Interactable)
            }
            else if response.collisionMask == .WORLD
            {
                if diffX < diffY
                {
                    if aPos.y < bPos.y
                    {
                        aPos.y = aBottom - (aTop - (bBottom - 1)) - Int(a.size.height / 2)
                    }
                    else
                    {
                        aPos.y = bTop + Int(a.size.height / 2)
                    }
                }
                else if diffX > diffY
                {
                    if aPos.x < bPos.x
                    {
                        aPos.x = aLeft - (aRight - bLeft) - Int(a.size.width / 2)
                    }
                    else
                    {
                        aPos.x = bRight + Int(a.size.width / 2) + 1
                    }
                }
            }
        }
//        else if interact.interactable == response
//        {
//            interact.interactable = nil
//        }
    }
    
//    func updateCamera(player: SKNode)
//    {
//        GameScene.setupCamera(player)
//    }

}
