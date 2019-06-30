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
    
    var enemyIdle : SKAction?
    var eiTextures :[SKTexture] = []
    
    var enemyAtkR : SKAction?
    var eatkRTextures : [SKTexture] = []
    var enemyAtkL : SKAction?
    var eatkLTextures : [SKTexture] = []
    
    var enemyHitL : SKAction?
    var ehLTextures : [SKTexture] = []
    var enemyHitR : SKAction?
    var ehRTextures : [SKTexture] = []
    
    var enemyDeathR : SKAction?
    var edRTextures : [SKTexture] = []
    var enemyDeathL : SKAction?
    var edLTextures : [SKTexture] = []
    
    let animSpeed = 0.1
    
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
        stats.append(10)
        
        super.init(x : x, y : y, z : z, s : s, st : stats)
        setAnimations()
        startAnimation(animAction: enemyIdle!, animKey: "idle")
    }
    
    func setAnimations()
    {
        for i in 1...9
        {
            eiTextures.append(SKTexture(pixelImageNamed: "Skeleton-Idle_0\(i)"))
        }
        for i in 10...11
        {
            eiTextures.append(SKTexture(pixelImageNamed: "Skeleton-Idle_\(i)"))
        }
        for i in 1...9
        {
            eatkRTextures.append(SKTexture(pixelImageNamed: "Skeleton-Attack_0\(i)"))
        }
        for i in 10...18
        {
            eatkRTextures.append(SKTexture(pixelImageNamed: "Skeleton-Attack_\(i)"))
        }
        for i in 1...9
        {
            eatkLTextures.append(SKTexture(pixelImageNamed: "LSkeleton-Attack_0\(i)"))
        }
        for i in 10...18
        {
            eatkLTextures.append(SKTexture(pixelImageNamed: "LSkeleton-Attack_\(i)"))
        }
        for i in 1...8
        {
            ehRTextures.append(SKTexture(pixelImageNamed: "Skeleton-Hit_0\(i)"))
        }
        for i in 1...8
        {
            ehLTextures.append(SKTexture(pixelImageNamed: "LSkeleton-Hit_0\(i)"))
        }
        for i in 1...9
        {
            edRTextures.append(SKTexture(pixelImageNamed: "Skeleton-Dead_0\(i)"))
        }
        for i in 10...15
        {
            edRTextures.append(SKTexture(pixelImageNamed: "Skeleton-Dead_\(i)"))
        }
        for i in 1...9
        {
            edLTextures.append(SKTexture(pixelImageNamed: "LSkeleton-Dead_0\(i)"))
        }
        for i in 10...15
        {
            edLTextures.append(SKTexture(pixelImageNamed: "LSkeleton-Dead_\(i)"))
        }
        
        enemyIdle = SKAction.animate(with: eiTextures, timePerFrame: animSpeed)
        
        enemyAtkR = SKAction.animate(with: eatkRTextures, timePerFrame: animSpeed)
        var tempAnim = SKAction.animate(with: eatkLTextures, timePerFrame: animSpeed)
        enemyAtkL = tempAnim.reversed()
        
        enemyHitR = SKAction.animate(with: ehRTextures, timePerFrame: animSpeed)
        tempAnim = SKAction.animate(with: ehLTextures, timePerFrame: animSpeed)
        enemyHitL = tempAnim.reversed()
        
        enemyDeathR = SKAction.animate(with: edRTextures, timePerFrame: animSpeed)
        tempAnim = SKAction.animate(with: edLTextures, timePerFrame: animSpeed)
        enemyDeathL = tempAnim.reversed()
        
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

//playerIdle = SKAction.animate(with: piTextures, timePerFrame: animSpeed)
//playerLeft = SKAction.animate(with: plTextures, timePerFrame: animSpeed)
//playerRight = SKAction.animate(with: prTextures, timePerFrame: animSpeed)
//playerUp = SKAction.animate(with: puTextures, timePerFrame: animSpeed)
//playerDown = SKAction.animate(with: pdTextures, timePerFrame: animSpeed)
//}




