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
    
    var upRight : Button?
    var upLeft : Button?
    var downRight : Button?
    var downLeft : Button?

    var interact : Button?
    
    var direction : Direction
    var lastDirection : Direction
    
    var stats : Stats
    
    let movSpeed = 3
    let animSpeed = 0.2
    var isIdle = true
    var tempString: String?
    
    var playerIdle: SKAction?
    var piTextures:[SKTexture] = []
    
    var playerLeft: SKAction?
    var plTextures:[SKTexture] = []
    
    var playerRight: SKAction?
    var prTextures:[SKTexture] = []
    
    var playerUp: SKAction?
    var puTextures:[SKTexture] = []
    
    var playerDown: SKAction?
    var pdTextures:[SKTexture] = []

    let uiGap = 5
    let uiBuffer = 2
    let uiBotMargin = 9
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode)
    {    
        stats = Stats(s : 5, d : 5, c : 5)
    
        direction = .NONE
        lastDirection = .NONE
    
        left = Button(x: (GameScene.gridSize! * -11),y: (GameScene.gridSize! * -4) + uiBotMargin + uiGap,z: 5, s: BSNode(imageNamed: "arrow_left"))
        s.addChild(left!.sprite!)
        right = Button(x: (GameScene.gridSize! * -9) + (uiGap * 2),y: (GameScene.gridSize! * -4) + uiBotMargin + uiGap,z: 5, s: BSNode(imageNamed: "arrow_right"))
        s.addChild(right!.sprite!)
        up = Button(x: (GameScene.gridSize! * -10) + uiGap,y: (GameScene.gridSize! * -3) + uiBotMargin + (uiGap * 2),z: 5, s: BSNode(imageNamed: "arrow_up"))
        s.addChild(up!.sprite!)
        down = Button(x: (GameScene.gridSize! * -10) + uiGap,y: (GameScene.gridSize! * -5) + uiBotMargin,z: 5, s: BSNode(imageNamed: "arrow_down"))
        s.addChild(down!.sprite!)
        interact = Button(x: (GameScene.gridSize! * -10) + uiGap,y: (GameScene.gridSize! * -4) + uiBotMargin + uiGap,z: 5, s: BSNode(imageNamed: "btn_interact"))
        s.addChild(interact!.sprite!)
    
        downLeft = Button(x: (GameScene.gridSize! * -11) + uiBuffer,y: (GameScene.gridSize! * -5) + uiBotMargin + uiBuffer,z: 5, s: BSNode(imageNamed: "downLeft"))
        s.addChild(downLeft!.sprite!)
        downRight = Button(x: (GameScene.gridSize! * -9) + (uiGap * 2) - uiBuffer,y: (GameScene.gridSize! * -5) + uiBotMargin + uiBuffer,z: 5, s: BSNode(imageNamed: "downRight"))
        s.addChild(downRight!.sprite!)
        upLeft = Button(x: (GameScene.gridSize! * -11) + uiBuffer,y: (GameScene.gridSize! * -3) + uiBotMargin + (uiGap * 2) - uiBuffer,z: 5, s: BSNode(imageNamed: "upLeft"))
        s.addChild(upLeft!.sprite!)
        upRight = Button(x: (GameScene.gridSize! * -9) + (uiGap * 2) - uiBuffer,y: (GameScene.gridSize! * -3) + uiBotMargin + (uiGap * 2) - uiBuffer,z: 5, s: BSNode(imageNamed: "upRight"))
        s.addChild(upRight!.sprite!)

        super.init(x : x, y : y, z: z, s : s, m : .PLAYER)
        GameScene.player = self
        setAnimations()
        let dim = CGSize(width: 32, height: 32)
        self.sprite?.size = dim
    }
    
    override func update()
    {
        //updateCamera(player: self.sprite as! SKNode)
        if left!.active == false &&
            right!.active == false &&
            up!.active == false &&
            down!.active == false
        {
            lastDirection = direction
            direction = .NONE
            isIdle = true
            if tempString != nil && tempString != "playerIdle"
            {
                stopAnimation(animKey: tempString!)
            }
        }
        else
        {
            isIdle = false
        }
        if isIdle && tempString != "playerIdle"
        {
            tempString = "playerIdle"
            startAnimation(animAction: playerIdle!, animKey: tempString!)
        }
        else
        {
            if left!.active
            {
                tempString = "playerLeft"
                startAnimation(animAction: playerLeft!, animKey: tempString!)
                lastDirection = direction
                direction = .LEFT
                sprite!.position.x -= CGFloat(movSpeed)
            }
            if right!.active
            {
                tempString = "playerRight"
                startAnimation(animAction: playerRight!, animKey: tempString!)
                lastDirection = direction
                direction = .RIGHT
                sprite!.position.x += CGFloat(movSpeed)
            }
            if up!.active
            {
                tempString = "playerUp"
                startAnimation(animAction: playerUp!, animKey: tempString!)
                lastDirection = direction
                direction = .UP
                sprite!.position.y += CGFloat(movSpeed)
            }
            if down!.active
            {
                tempString = "playerDown"
                startAnimation(animAction: playerDown!, animKey: tempString!)
                lastDirection = direction
                direction = .DOWN
                sprite!.position.y -= CGFloat(movSpeed)
            }
            if interact!.active
            {
                interact!.interactable!.act()
            }
        }
        
        pos.x = Int(sprite!.position.x)
        pos.y = Int(sprite!.position.y)
    }

    override func collision(response : Entity)
    {
        
        let a = self.sprite!
        let aBottom = self.pos.y - Int(a.size.height / 2)
        let aTop = self.pos.y - Int(a.size.height / 4)
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
                interact!.interactable!.player = self
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
                        aPos.y += bTop - (aBottom - 1)
                    }
                    if lastDirection == .RIGHT
                    {
                        aPos.x = bRight - (aLeft - 1)
                    }
                    if lastDirection == .LEFT
                    {
                        aPos.x = aRight - (bLeft - 1)
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
                        aPos.y += bTop - (aBottom - 1)
                    }
                    if direction == .RIGHT
                    {
                        aPos.x -= aRight - (bLeft - 1)
                    }
                    if direction == .LEFT
                    {
                        aPos.x += bRight - (aLeft - 1)
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
    
    func setAnimations()
    {
        for i in 0...3
        {
            piTextures.append(SKTexture(pixelImageNamed: "knight iso char_idle_\(i)"))
        }
        for i in 0...5
        {
            plTextures.append(SKTexture(pixelImageNamed: "knight iso char_run left_\(i)"))
        }
        for i in 0...5
        {
            prTextures.append(SKTexture(pixelImageNamed: "knight iso char_run right_\(i)"))
        }
        for i in 0...4
        {
            puTextures.append(SKTexture(pixelImageNamed: "knight iso char_run up_\(i)"))
        }
        for i in 0...4
        {
            pdTextures.append(SKTexture(pixelImageNamed: "knight iso char_run down_\(i)"))
        }
        playerIdle = SKAction.animate(with: piTextures, timePerFrame: animSpeed)
        playerLeft = SKAction.animate(with: plTextures, timePerFrame: animSpeed)
        playerRight = SKAction.animate(with: prTextures, timePerFrame: animSpeed)
        playerUp = SKAction.animate(with: puTextures, timePerFrame: animSpeed)
        playerDown = SKAction.animate(with: pdTextures, timePerFrame: animSpeed)
    }
    
    func startAnimation(animAction: SKAction, animKey: String)
    {
        if sprite!.action(forKey: animKey) == nil
        {
            sprite!.run(SKAction.repeatForever(animAction), withKey: animKey)
        }
    }
    
    func stopAnimation(animKey: String)
    {
        sprite!.removeAction(forKey: animKey)
    }
}
