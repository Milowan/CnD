//
//  LesserSkeleton.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-28.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class LesserSkeleton : Enemy
{
    var scale : SKAction?
    var enemyIdleL : SKAction?
    var eiLTextures : [SKTexture] = []
    var enemyIdleR : SKAction?
    var eiRTextures : [SKTexture] = []
    
    var enemyAtkR : SKAction?
    var eatkRTextures : [SKTexture] = []
    var enemyAtkL : SKAction?
    var eatkLTextures : [SKTexture] = []
    
    var enemyDeathR : SKAction?
    var edRTextures : [SKTexture] = []
    var enemyDeathL : SKAction?
    var edLTextures : [SKTexture] = []
    
    let animSpeed = 0.1
    var newCombat = true
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode)
    {
        var stats = [Int]()
        
        //dmg
        stats.append(3)
        //ats
        stats.append(7)
        //def
        stats.append(2)
        //evs
        stats.append(1)
        //prs
        stats.append(2)
        //hp
        stats.append(30)
        
        super.init(x : x, y : y, z : z, s : s, st : stats)
        setAnimations()
        startAnimation(animAction: enemyIdleL!, animKey: "idleL")
    }
    
    override func update()
    {
        super.update()
        if !isAlive && player!.cDir == 0
        {
            runAnimation(animAction: enemyDeathL!, animKey: "death")
            if !sprite!.actionForKeyIsRunning(key: "death")
            {
                isDespawned = true
            }
        }
        else
        {
            if inCombat && newCombat
            {
                startAnimation(animAction: enemyIdleL!, animKey: "idleL")
                newCombat = false
            }
            if inCombat
            {
                let atkCD = player!.combatTimer % ats
                if atkCD == 0
                {
                    if !sprite!.actionForKeyIsRunning(key: "atkLeft")
                    {
                        self.runAnimation(animAction: enemyAtkL!, animKey: "atkLeft")
                        if arc4random_uniform( (UInt32(50))) > player!.calcTotalEVS() / prs
                        {
                            player!.dmgTaken += dmg / player!.calcTotalDEF()
                            newCombat = true
                        }
                    }
                }
            }
        }
        if !isAlive && player!.cDir == 1
        {
            runAnimation(animAction: enemyDeathL!, animKey: "death")
            if !sprite!.actionForKeyIsRunning(key: "death")
            {
                isDespawned = true
            }
        }
        else
        {
            if inCombat && newCombat
            {
                    startAnimation(animAction: enemyIdleL!, animKey: "idleR")
                    newCombat = false
                }
                if inCombat
                {
                    let atkCD = player!.combatTimer % ats
                    if atkCD == 0
                    {
                        if !sprite!.actionForKeyIsRunning(key: "atkRight")
                        {
                            self.runAnimation(animAction: enemyAtkR!, animKey: "atkRight")
                            if arc4random_uniform( (UInt32(50))) > player!.calcTotalEVS() / prs
                            {
                                player!.dmgTaken += dmg / player!.calcTotalDEF()
                                newCombat = true
                            }
                        }
                    }
                }
            }
        }
        
    
    
    
    
    func setAnimations()
    {
        for i in 1...4
        {
            eiRTextures.append(SKTexture(pixelImageNamed: "Skeleton-Idle_0\(i)"))
        }
        for i in 1...4
        {
            eiLTextures.append(SKTexture(pixelImageNamed: "LSkeleton-Idle_0\(i)"))
        }
        for i in 1...4
        {
            eatkRTextures.append(SKTexture(pixelImageNamed: "Skeleton-Attack_0\(i)"))
        }
        for i in 1...4
        {
            eatkLTextures.append(SKTexture(pixelImageNamed: "LSkeleton-Attack_0\(i)"))
        }
        for i in 1...5
        {
            edRTextures.append(SKTexture(pixelImageNamed: "Skeleton-Dead_0\(i)"))
        }
        for i in 1...5
        {
            edLTextures.append(SKTexture(pixelImageNamed: "LSkeleton-Dead_0\(i)"))
        }
        
        enemyIdleR = SKAction.animate(with: eiRTextures, timePerFrame: animSpeed)
        enemyIdleL = SKAction.animate(with: eiLTextures, timePerFrame: animSpeed)
        
        enemyAtkR = SKAction.animate(with: eatkRTextures, timePerFrame: animSpeed)
        var tempAnim = SKAction.animate(with: eatkLTextures, timePerFrame: animSpeed)
        enemyAtkL = tempAnim.reversed()
        
        enemyDeathR = SKAction.animate(with: edRTextures, timePerFrame: animSpeed)
        tempAnim = SKAction.animate(with: edLTextures, timePerFrame: animSpeed)
        enemyDeathL = tempAnim.reversed()
        
    }
    
    func runAnimation(animAction: SKAction, animKey: String)
    {
        if sprite!.action(forKey: animKey) == nil
        {
            sprite!.run((animAction), withKey: animKey)
        }
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




