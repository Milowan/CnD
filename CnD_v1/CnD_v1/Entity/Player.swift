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
    var left : Button
    var right : Button
    var up : Button
    var down : Button
    
    var dPadBG : SKSpriteNode
    var upRight : SKSpriteNode
    var upLeft : SKSpriteNode
    var downRight : SKSpriteNode
    var downLeft : SKSpriteNode
    var dmTextBar : SKSpriteNode
    
    var sword : Sword?
    var armour : Armour?
    var helmet : Helmet?
    
    var inCombat : Bool
    var combatTimer : Int
    var victory : Bool
    var target : Enemy?
    var dmgTaken : Float
    var cDir : Int?
    
    var plate : PressPlates?
    var onPlate = false

    var interactButton : Button
    var miniMapButton : Button
    var inventoryButton : Button
    let scale = SKAction.scale(to: 0.75, duration: 0.5)
    
    var direction : Direction
    var lastDirection : Direction
    
    let stats = Stats(s : 12, d : 15, c : 10)
    var inventory : Inventory?
    var map : Map?
    
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
    
    var playerAtkLeft: SKAction?
    var palTextures: [SKTexture] = []
    var playerAtkRight: SKAction?
    var parTextures: [SKTexture] = []

    let uiGap = 5
    let uiBuffer = 2
    let uiBotMargin = 9
    
//    let hitText = HUD()
//    let harmText = HUD()
    
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode)
    {
        direction = .NONE
        lastDirection = .NONE
        
        inCombat = false
        combatTimer = 0
        victory = false
        dmgTaken =  0
    
        left = Button(x: (GameScene.gridSize! * -11),y: (GameScene.gridSize! * -4) + uiBotMargin + uiGap,z: 6, s: BSNode(imageNamed: "arrow_left"))
        s.addChild(left.sprite)
        left.sprite.texture!.filteringMode = .nearest
        
        right = Button(x: (GameScene.gridSize! * -9) + (uiGap * 2),y: (GameScene.gridSize! * -4) + uiBotMargin + uiGap,z: 6, s: BSNode(imageNamed: "arrow_right"))
        s.addChild(right.sprite)
        right.sprite.texture!.filteringMode = .nearest
        
        up = Button(x: (GameScene.gridSize! * -10) + uiGap,y: (GameScene.gridSize! * -3) + uiBotMargin + (uiGap * 2),z: 6, s: BSNode(imageNamed: "arrow_up"))
        s.addChild(up.sprite)
        up.sprite.texture!.filteringMode = .nearest
        
        down = Button(x: (GameScene.gridSize! * -10) + uiGap,y: (GameScene.gridSize! * -5) + uiBotMargin,z: 6, s: BSNode(imageNamed: "arrow_down"))
        s.addChild(down.sprite)
        down.sprite.texture!.filteringMode = .nearest
    
        dPadBG = SKSpriteNode(imageNamed : "btn_interact")
        dPadBG.position.x = CGFloat((GameScene.gridSize! * -10) + 5)
        dPadBG.position.y = CGFloat((GameScene.gridSize! * -4) + 14)
        dPadBG.zPosition = CGFloat(5)
        dPadBG.texture!.filteringMode = .nearest
        s.addChild(dPadBG)
        downLeft = SKSpriteNode(imageNamed : "downLeft")
        downLeft.position.x = CGFloat((GameScene.gridSize! * -11) + uiBuffer)
        downLeft.position.y = CGFloat((GameScene.gridSize! * -5) + uiBotMargin + uiBuffer)
        downLeft.zPosition = CGFloat(6)
        downLeft.texture!.filteringMode = .nearest
        s.addChild(downLeft)
        downRight = SKSpriteNode(imageNamed: "downRight")
        downRight.position.x = CGFloat((GameScene.gridSize! * -9) + (uiGap * 2) - uiBuffer)
        downRight.position.y = CGFloat((GameScene.gridSize! * -5) + uiBotMargin + uiBuffer)
        downRight.zPosition = CGFloat(6)
        downRight.texture!.filteringMode = .nearest
        s.addChild(downRight)
        upLeft = SKSpriteNode(imageNamed: "upLeft")
        upLeft.position.x = CGFloat((GameScene.gridSize! * -11) + uiBuffer)
        upLeft.position.y = CGFloat((GameScene.gridSize! * -3) + uiBotMargin + (uiGap * 2) - uiBuffer)
        upLeft.zPosition = CGFloat(6)
        upLeft.texture!.filteringMode = .nearest
        s.addChild(upLeft)
        upRight = SKSpriteNode(imageNamed : "upRight")
        upRight.position.x = CGFloat((GameScene.gridSize! * -9) + (uiGap * 2) - uiBuffer)
        upRight.position.y = CGFloat((GameScene.gridSize! * -3) + uiBotMargin + (uiGap * 2) - uiBuffer)
        upRight.zPosition = CGFloat(6)
        upRight.texture!.filteringMode = .nearest
        s.addChild(upRight)
        dmTextBar = SKSpriteNode(imageNamed: "dmTextBar")
        dmTextBar.position.x = CGFloat(GameScene.gridSize! / 2) //- uiBotMargin)
        dmTextBar.position.y = CGFloat((GameScene.gridSize! * -5) - (uiGap * 2) - uiBuffer)
        dmTextBar.zPosition = CGFloat(6)
        dmTextBar.size.height = (dmTextBar.size.height / 2)
        dmTextBar.texture?.filteringMode = .nearest
        s.addChild(dmTextBar)
        
        miniMapButton = Button(x: (GameScene.gridSize! * 11), y: (GameScene.gridSize! * -2) + uiBuffer, z: 5, s: BSNode(imageNamed: "mapIcon"))
        s.addChild(miniMapButton.sprite)
        miniMapButton.sprite.texture!.filteringMode = .nearest
        miniMapButton.sprite.run(scale)
        inventoryButton = Button(x: (GameScene.gridSize! * 10) - (uiGap*2), y: (GameScene.gridSize! * -2) - (uiGap*2), z: 5, s: BSNode(imageNamed: "inventoryIcon"))
        s.addChild(inventoryButton.sprite)
        inventoryButton.sprite.texture!.filteringMode = .nearest
        inventoryButton.sprite.run(scale)
        interactButton = Button(x: (GameScene.gridSize! * 11),y: (GameScene.gridSize! * -4),z: 5, s: BSNode(imageNamed: "interactIcon"))
        s.addChild(interactButton.sprite)
        interactButton.sprite.texture!.filteringMode = .nearest
        
        
        let dim = CGSize(width: 32, height: 32)
        s.size = dim
        super.init(x : x, y : y, z: z, s : s, m : .PLAYER)
        
        inventory = Inventory(p: self)
        map = Map(p: self)
//        hitText.position.x = CGFloat(self.pos.x + 10)
//        hitText.position.y = CGFloat(self.pos.y)
//        hitText.zPosition = 55
//        harmText.position.x = CGFloat(self.pos.x - 10)
//        harmText.position.y = CGFloat(self.pos.y)
//        harmText.zPosition = 55
//        hitText.aHitText(t: "25")
//        hitText.aTextField(t: "TEXT")
////        harmText.aHarmfulText(t: "25")
//        //s.addChild(hitText)
//        s.addChild(harmText)
        self.sword = WoodenSword(p : self)
        self.armour = Armour(p : self, st : Stats(s : 1, d : 1, c : 1), sp : ISNode(imageNamed: "sword_01a"))
        self.helmet = Helmet(p : self, st : Stats(s : 1, d : 1, c : 1), sp : ISNode(imageNamed: "sword_01a"))
        setAnimations()
    }
    
    override func update()
    {
        if Int(dmgTaken) < calcMaxHP()
        {
            if !inCombat
            {
                
                if dmgTaken > 0
                {
                    dmgTaken -= 0.1625
                }
                
                if left.active == false &&
                    right.active == false &&
                    up.active == false &&
                    down.active == false
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
                    if left.active
                    {
                        tempString = "playerLeft"
                        startAnimation(animAction: playerLeft!, animKey: tempString!)
                        lastDirection = direction
                        direction = .LEFT
                        sprite!.position.x -= CGFloat(movSpeed)
                    }
                    if right.active
                    {
                        tempString = "playerRight"
                        startAnimation(animAction: playerRight!, animKey: tempString!)
                        lastDirection = direction
                        direction = .RIGHT
                        sprite!.position.x += CGFloat(movSpeed)
                    }
                    if up.active
                    {
                        tempString = "playerUp"
                        startAnimation(animAction: playerUp!, animKey: tempString!)
                        lastDirection = direction
                        direction = .UP
                        sprite!.position.y += CGFloat(movSpeed)
                    }
                    if down.active
                    {
                        tempString = "playerDown"
                        startAnimation(animAction: playerDown!, animKey: tempString!)
                        lastDirection = direction
                        direction = .DOWN
                        sprite!.position.y -= CGFloat(movSpeed)
                    }
                    
                    if interactButton.active
                    {
                        if !interactButton.clear
                        {
                            if let interactable = interactButton.interactable
                            {
                                interactable.act()
                            }
                            interactButton.clear = true
                        }
                    }
                    if inventoryButton.active
                    {
                        if !inventoryButton.clear
                        {
                            inventory!.act()
                        }
                        inventoryButton.clear = true
                    }
                    if miniMapButton.active
                    {
                        if !miniMapButton.clear
                        {
                            map!.act()
                        }
                        miniMapButton.clear = true
                    }
                }
            }
            else if victory
            {
                inCombat = false
                combatTimer = 0
                victory = false
            }
            else
            {
                if cDir == 0
                {
                    let atkCD = combatTimer % calcTotalATS()
                    if atkCD == 0
                    {
                        if !sprite!.actionForKeyIsRunning(key: "atkLeft")
                        {
                            self.runAnimation(animAction: playerAtkLeft!, animKey: "atkLeft")
                            if arc4random_uniform( (UInt32(50))) > target!.evs / calcTotalPRS()
                            {
                                self.target!.hp -= self.calcTotalDMG() / self.target!.def
                            }
                        }
                    }
                    if !target!.isAlive
                    {
                        victory = true
                    }
                }
                if cDir == 1
                {
                    let atkCD = combatTimer % calcTotalATS()
                    if atkCD == 0
                    {
                        if !sprite!.actionForKeyIsRunning(key: "atkRight")
                        {
                            self.runAnimation(animAction: playerAtkRight!, animKey: "atkRight")
                            self.target!.hp -= self.calcTotalDMG() / self.target!.def
                        }
                    }
                    if !target!.isAlive
                    {
                        victory = true
                    }
                }
                combatTimer += 1
            }
            
        }
        else
        {
            //lose condition
        }
        pos.x = Int(sprite!.position.x)
        pos.y = Int(sprite!.position.y)
        inventory!.update()
        map!.update()
    }


    override func collision(response : Entity)
    {
        
        let a = self.sprite!
        let aBottom = self.pos.y - Int(a.frame.height / 2)
        let aTop = self.pos.y - Int(a.frame.height / 4)
        let aLeft = self.pos.x - Int((a.frame.width / 4) / 2)
        let aRight = self.pos.x + Int((a.frame.width / 4) / 2)
        
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
        
        if aBottom <= bTop + 15 &&
        aTop >= bBottom - 25 &&
        aLeft <= bRight &&
        aRight >= bLeft
        {
            
            if let interactable = response as? Interactable
            {
                interactButton.interactable = interactable
                interactButton.interactable!.player = self
            }
            
            if let enemy = response as? Enemy
            {
                if enemy.isAlive
                {
                    target = enemy
                    inCombat = true
                    target!.player = self
                    target!.inCombat = true
                    if self.pos.x < enemy.pos.x
                    {
                        cDir = 0
                    }
                    if self.pos.x > enemy.pos.x
                    {
                        cDir = 1
                    }
                }
            }
                
            
        }
        else if interactButton.interactable == response
        {
            interactButton.interactable!.player = nil
            interactButton.interactable = nil
        }
        
        if aBottom <= bTop &&
            aTop >= bBottom &&
            aLeft <= bRight &&
            aRight >= bLeft
        {
            
            if let plate = (response as? PressPlates)
            {
                plate.act()
                self.plate = plate
                onPlate = true
            }
            
            if response.collisionMask == .WORLD
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
        else if plate == response
        {
            plate!.stood = false
            plate!.act()
            plate!.stood = false
            plate = nil
            
            onPlate = false
        }
        
        pos = Pos(xX : aPos.x, yY : aPos.y + Int(a.frame.size.height / 4))
        
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
        for i in 0...1
        {
            palTextures.append(SKTexture(pixelImageNamed: "knight iso char_slice left_\(i)"))
        }
        for i in 0...1
        {
            parTextures.append(SKTexture(pixelImageNamed: "knight iso char_slice right_\(i)"))
        }
        playerIdle = SKAction.animate(with: piTextures, timePerFrame: animSpeed)
        playerLeft = SKAction.animate(with: plTextures, timePerFrame: animSpeed)
        playerRight = SKAction.animate(with: prTextures, timePerFrame: animSpeed)
        playerUp = SKAction.animate(with: puTextures, timePerFrame: animSpeed)
        playerDown = SKAction.animate(with: pdTextures, timePerFrame: animSpeed)
        playerAtkLeft = SKAction.animate(with: palTextures, timePerFrame: 0.4)
        playerAtkRight = SKAction.animate(with: parTextures, timePerFrame: 0.4)
    }
    
    func startAnimation(animAction: SKAction, animKey: String)
    {
        if sprite!.action(forKey: animKey) == nil
        {
            sprite!.run(SKAction.repeatForever(animAction), withKey: animKey)
        }
    }
    
    func runAnimation(animAction: SKAction, animKey: String)
    {
        if sprite!.action(forKey: animKey) == nil
        {
            sprite!.run((animAction), withKey: animKey)
        }
    }
    
    func stopAnimation(animKey: String)
    {
        sprite!.removeAction(forKey: animKey)
    }
    
    func calcTotalDMG() -> Int
    {
        var dmg = 0
        
        if let sword = self.sword
        {
            dmg = (self.stats.STR + sword.stats.STR) / ((self.stats.CON + sword.stats.CON)/2) + sword.baseDamage
        }
        
        return dmg
    }
    
    func calcTotalATS() -> Int
    {
        var s = 0
        
        if let sword = self.sword
        {
            s = (self.stats.DEX + sword.stats.DEX) / ((self.stats.CON + sword.stats.CON)/2) + sword.baseSpeed
        }
        
        return s
    }
    
    func calcTotalDEF() -> Int
    {
        var def = 0
        
        if let armour = self.armour ,
            let helmet = self.helmet
        {
            def = (((self.stats.STR + armour.stats.STR) / ((self.stats.CON + armour.stats.CON)/2) + armour.baseDef)
            + ((self.stats.STR + helmet.stats.STR) / ((self.stats.CON + helmet.stats.CON)/2) + helmet.baseDef))
        }
        
        return def
    }
    
    func calcTotalEVS() -> Int
    {
        var s = 0
        
        if let armour = self.armour
        {
            s = (self.stats.DEX + armour.stats.DEX) / (self.stats.CON + armour.stats.CON) + armour.baseEvasion
        }
        
        return s
    }
    
    func calcTotalPRS() -> Int
    {
        var s = 0
        
        if let helmet = self.helmet
        {
            s = (self.stats.DEX + helmet.stats.DEX) / (self.stats.CON + helmet.stats.CON) + helmet.basePrecision
        }
        
        return s
    }
    
    func calcMaxHP() -> Int
    {
        var s = 0
        
        if let sword = self.sword,
        let helmet = self.helmet,
        let armour = self.armour
        {
            s = self.stats.CON + helmet.stats.CON + armour.stats.CON + sword.stats.CON
        }
        
        return s
    }
    
    func removeRock()
    {
        var i = 0
        for item in inventory!.contents
        {
            if let rock = item as? Rock
            {
                inventory!.contents.remove(at : i)
                break
            }
            i += 1
        }
    }
    
    func removeGem()
    {
        var i = 0
        for item in inventory!.contents
        {
            if let gem = item as? Gem
            {
                inventory!.contents.remove(at : i)
                break
            }
            i += 1
        }
    }}
