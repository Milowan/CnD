//
//  GreaterSkeleton.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-28.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation

import SpriteKit

class GreaterSkeleton : Enemy
{
    var tempTimer = 0
    
    var enemyAtkR : SKAction?
    var eatkRTextures : [SKTexture] = []
    
    let animSpeed = 0.3
    let atkAnimSp = 0.1
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode)
    {
        var stats = [Int]()
        
        //dmg
        stats.append(6)
        //ats
        stats.append(10)
        //def
        stats.append(3)
        //evs
        stats.append(2)
        //prs
        stats.append(4)
        //hp
        stats.append(25)
        super.init(x : x, y : y, z : z, s : s, st : stats, str: "GreaterSkeleton")
        setAnimations()
    }
        
    override func update()
    {
        super.update()
        if isAlive
        {
            if inCombat
            {
                let atkCD = player!.combatTimer % ats
                if atkCD == 0
                {
                    self.runAnimation(animAction: enemyAtkR!, animKey: "atkRight")
                    if arc4random_uniform( (UInt32(50))) > player!.calcTotalEVS() / prs
                    {
                        player!.dmgTaken += Float(dmg / player!.calcTotalDEF())
                    }
                }
            }
        }
        if !isAlive && inCombat
        {
            tempTimer += 1
            if tempTimer == 30
            {
                isDespawned = true
                tempTimer = 0
            }
        }
    }
    
    func setAnimations()
    {
        for i in 1...4
        {
            eatkRTextures.append(SKTexture(pixelImageNamed: "undead_attack_sheet_0\(i)"))
        }
        
        enemyAtkR = SKAction.animate(with: eatkRTextures, timePerFrame: atkAnimSp)
        
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
