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

    var left : Button?
    var right : Button?
    var up : Button?
    var down : Button?
    var interact : Button?
    
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
    
    let movSpeed = 3
    var uiGap = 5
    var uiBotMargin = 9
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("Use init()")
    }

    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode, buttons : [BSNode])
   {
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

        super.init(x : x, y : y, z: z, s : s, m : .PLAYER)
        GameScene.player = self
        setAnimations()
        let dim = CGSize(width: 32, height: 32)
        self.sprite?.size = dim
    }
    
    override func update()
    {
        if left!.active == false &&
            right!.active == false &&
            up!.active == false &&
            down!.active == false
        {
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
                sprite!.position.x -= CGFloat(movSpeed)
            }
            if right!.active
            {
                tempString = "playerRight"
                startAnimation(animAction: playerRight!, animKey: tempString!)
                sprite!.position.x += CGFloat(movSpeed)
            }
            if up!.active
            {
                tempString = "playerUp"
                startAnimation(animAction: playerUp!, animKey: tempString!)
                sprite!.position.y += CGFloat(movSpeed)
            }
            if down!.active
            {
                tempString = "playerDown"
                startAnimation(animAction: playerDown!, animKey: tempString!)
                sprite!.position.y -= CGFloat(movSpeed)
            }
            if interact!.active
            {
                
            }
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
                interact!.interactable = (response as! Interactable)
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
        else if interact!.interactable == response
        {
            interact!.interactable = nil
        }
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
