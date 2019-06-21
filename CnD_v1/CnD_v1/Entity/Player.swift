//
//  Player.swift
//  CnD
//
//  Created by Gavin McGuire on 2019-06-03.
//  Copyright © 2019 trios. All rights reserved.
//

import Foundation
import SpriteKit

enum Direction
{
    case UP
    case DOWN
    case LEFT
    case RIGHT
    case NONE
}


class Player : Entity
{

    var left : Button?
    var right : Button?
    var up : Button?
    var down : Button?
    var interact : Button?
    
    var direction : Direction
    var lastDirection : Direction
    
    var stats : Stats
    
    let movSpeed = 2
    var uiGap = 5
    var uiBotMargin = 8
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode, buttons : [BSNode])
   {
    
    stats = Stats(s : 5, d : 5, c : 5)
    
        for (index, value) in buttons.enumerated()
        {
            if index == 0
            {
                left = Button(x: (GameScene.gridSize! * -11),y: (GameScene.gridSize! * -4) + uiBotMargin + uiGap,z: 5, s: value)
            }
            if index == 1
            {
                right = Button(x: (GameScene.gridSize! * -9) + (uiGap * 2),y: (GameScene.gridSize! * -4) + uiBotMargin + uiGap,z: 5, s: value)
            }
            if index == 2
            {
                up = Button(x: (GameScene.gridSize! * -10) + uiGap,y: (GameScene.gridSize! * -3) + uiBotMargin + (uiGap * 2),z: 5, s: value)
            }
            if index == 3
            {
                down = Button(x: (GameScene.gridSize! * -10) + uiGap,y: (GameScene.gridSize! * -5) + uiBotMargin,z: 5, s: value)
            }
            if index == 4
            {
                interact = Button(x: (GameScene.gridSize! * -10) + uiGap,y: (GameScene.gridSize! * -4) + uiBotMargin + uiGap,z: 5, s: value)
            }
        }
    
        direction = .NONE
        lastDirection = .NONE
    
        super.init(x : x, y : y, z: z, s : s, m : .PLAYER)
        let dim = CGSize(width: 32, height: 32)
        self.sprite?.size = dim
    }
    
    override func update()
    {
        //updateCamera(player: self.sprite as! SKNode)
        
        if left!.active == false && right!.active == false &&
        up!.active == false && down!.active == false
        {
            lastDirection = direction
            direction = .NONE
        }
        else
        {
            if left!.active
            {
                lastDirection = direction
                direction = .LEFT
                sprite!.position.x -= CGFloat(movSpeed)
            }
            if right!.active
            {
                lastDirection = direction
                direction = .RIGHT
                sprite!.position.x += CGFloat(movSpeed)
            }
            if up!.active
            {
                lastDirection = direction
                direction = .UP
                sprite!.position.y += CGFloat(movSpeed)
            }
            if down!.active
            {
                lastDirection = direction
                direction = .DOWN
                sprite!.position.y -= CGFloat(movSpeed)
            }
        }
        if interact!.active
        {

        }

        
        pos.x = Int(sprite!.position.x)
        pos.y = Int(sprite!.position.y)
    }

    override func collision(response : Entity)
    {
        
        let a = self.sprite!
        let aBottom = self.pos.y - Int(a.size.height / 2)
        let aTop = self.pos.y + Int(a.size.height / 2)
        let aLeft = self.pos.x - Int((a.size.width / 3) / 2)
        let aRight = self.pos.x + Int((a.size.width / 3) / 2)
        
        let aPos = Pos(xX : Int(a.position.x), yY : aBottom + Int(a.size.height / 4))
        
        var bBottom : Int
        var bTop : Int
        var bLeft : Int
        var bRight : Int
        if let b = response.sprite
        {
             bBottom = response.pos.y - Int(b.size.height / 2)
             bTop = response.pos.y + Int(b.size.height / 2)
             bLeft = response.pos.x - Int(b.size.width / 2)
             bRight = response.pos.x + Int(b.size.width / 2)
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
            
            if response.collisionMask == .INTERACTABLE
            {
                interact!.interactable = (response as! Interactable)
            }
            else if response.collisionMask == .WORLD
            {
                if direction == .NONE
                {
                    if lastDirection == .UP
                    {
                        aPos.y -= aTop - (bBottom - 1)
                    }
                    if lastDirection == .DOWN
                    {
                        aPos.y += bTop - aBottom
                    }
                    if lastDirection == .RIGHT
                    {
                        aPos.x = aRight - (bLeft - 1)
                    }
                    if lastDirection == .LEFT
                    {
                        aPos.x = bRight - (aLeft - 1)
                    }
                }
                else
                {
                    if direction == .UP
                    {
                        aPos.y -= aTop - (bBottom - 1)
                    }
                    if direction == .DOWN
                    {
                        aPos.y += bTop - aBottom
                    }
                    if direction == .RIGHT
                    {
                        aPos.x = aRight - (bLeft - 1)
                    }
                    if direction == .LEFT
                    {
                        aPos.x = bRight - (aLeft - 1)
                    }
                }
            }
        }
        else if interact!.interactable == response
        {
            interact!.interactable = nil
        }
        
        pos = Pos(xX : aPos.x, yY : aPos.y + Int(a.size.height / 4))
        
        sprite!.position.x = CGFloat(pos.x)
        sprite!.position.y = CGFloat(pos.y)
        
    }
    
//    func updateCamera(player: SKNode)
//    {
//        GameScene.setupCamera(player as! GameScene)
//    }

}
