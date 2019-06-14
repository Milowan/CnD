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
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("Use init()")
    }

    
   init (x : Int, y : Int, z : Int, s : SKSpriteNode)
   {
        left = Button(x: 0,y: 0,z: 5, s: SKSpriteNode(imageNamed: "arrow_left"))
        s.addChild(left.sprite as! BSNode)
        right = Button(x: 0,y: 0,z: 5, s: SKSpriteNode(imageNamed: "arrow_right"))
        s.addChild(right.sprite as! BSNode)
        up = Button(x: 0,y: 0,z: 5, s: SKSpriteNode(imageNamed: "arrow_up"))
        s.addChild(up.sprite as! BSNode)
        down = Button(x: 0,y: 0,z: 5, s: SKSpriteNode(imageNamed: "arrow_down"))
        s.addChild(down.sprite as! BSNode)
    
        interact = Button(x: 0,y: 0,z: 5, s: SKSpriteNode(imageNamed: "btn_interact"))
        s.addChild(interact.sprite as! BSNode)
        super.init(x : x, y : y, z: z, s : s, m : .PLAYER)
        let dim = CGSize(width: 32, height: 32)
        self.sprite?.size = dim
    }
    
    override func update()
    {
        //updateCamera(player: self.sprite as! SKNode)
        
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
        
        let a = self.sprite! as SKSpriteNode
        let aBottom = self.pos.y - Int(a.size.height / 2)
        let aTop = self.pos.y + Int(a.size.height / 2)
        let aLeft = self.pos.x - Int(a.size.width / 2)
        let aRight = self.pos.x + Int(a.size.width / 2)
        
        let b = response.sprite! as SKSpriteNode
        let bBottom = response.pos.y - Int(b.size.height / 2)
        let bTop = response.pos.y + Int(b.size.height / 2)
        let bLeft = response.pos.x - Int(b.size.width / 2)
        let bRight = response.pos.x + Int(b.size.width / 2)
        
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
                //interact.interactable = (response as! Interactable)
            }
            else if response.collisionMask == .WORLD
            {
                if diffX < diffY
                {
                    if pos.y < response.pos.y
                    {
                        pos.y = aBottom - (aTop - (bBottom - 1)) - Int(a.size.height / 2)
                    }
                    else
                    {
                        pos.y = bTop + Int(a.size.height / 2)
                    }
                }
                else if diffX > diffY
                {
                    if pos.x < response.pos.x
                    {
                        pos.x = aLeft - (aRight - bLeft) - Int(a.size.width / 2)
                    }
                    else
                    {
                        pos.x = bRight + Int(a.size.width / 2) + 1
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
