//
//  Ldoor.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-24.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit


class Adoor : Entity
{
    
    var isOpen : Bool
    var i : Int
    let animSpeed = 0.1
    var doorOpen: SKAction?
    var doorClosed: SKAction?
    var doorTextures:[SKTexture] = []
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode)
    {
        isOpen = false
        i = 0
        super.init(x : x, y : y, z : z, s : s, m : .WORLD)
        setDoorAnims()
    }
    
    func toggleState()
    {
        if isOpen
        {
            collisionMask = .WORLD
            startAnimation(animAction: doorClosed!, animKey: "close", sprite: sprite! as! SKSpriteNode)
        }
        else
        {
            collisionMask = .NONE
            startAnimation(animAction: doorOpen!, animKey: "close", sprite: sprite! as! SKSpriteNode)
        }
        isOpen = !isOpen
    }
    
    func setDoorAnims()
    {
        for i in 0...9
        {
            doorTextures.append(SKTexture(imageNamed: "frame000\(i)"))
        }
        for i in 10...12
        {
            doorTextures.append(SKTexture(imageNamed: "frame00\(i)"))
        }
        doorOpen = SKAction.animate(with: doorTextures, timePerFrame: animSpeed)
        doorClosed = doorOpen!.reversed()
    }
    
    func startAnimation(animAction: SKAction, animKey: String, sprite: SKSpriteNode)
    {
        if sprite.action(forKey: animKey) == nil
        {
            sprite.run(animAction)
        }
    }
    
    func stopAnimation(animKey: String)
    {
        self.sprite!.removeAction(forKey: animKey)
    }
}
