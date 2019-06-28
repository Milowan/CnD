//
//  Door.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-06-18.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

//let animSpeed = 0.1
//var doorOpen: SKAction?
//var doorClosed: SKAction?
//var doorTextures:[SKTexture] = []
//var sprite : SKSpriteNode?
//func setDoorAnims()
//{
//    for i in 0...9
//    {
//        doorTextures.append(SKTexture(imageNamed: "frame000\(i)"))
//    }
//    for i in 10...12
//    {
//        doorTextures.append(SKTexture(imageNamed: "frame00\(i)"))
//    }
//    doorOpen = SKAction.animate(with: doorTextures, timePerFrame: animSpeed)
//    doorClosed = doorOpen!.reversed()
//}
//
//func startAnimation(animAction: SKAction, animKey: String, sprite: SKSpriteNode, name: String)
//{
//    if sprite.action(forKey: animKey) == nil
//    {
//        sprite.run(SKAction.run(animAction, onChildWithName: name))
//    }
//}
//
//func stopAnimation(animKey: String)
//{
//    sprite!.removeAction(forKey: animKey)
//}

class Door: Interactable
{
    var isOpen : Bool
    var i : Int
    var name : String
    override init (x: Int, y: Int, z: Int, s: SKSpriteNode, n: String)
    {
        name = n
        isOpen = false
        i = 0
        super.init(x: x, y: y, z: z, s: s, n: n)
        //setDoorAnims()
        collisionMask = .WORLD
    }
    
    override func act()
    {
        i %= 2
        if i == 0
        {
            if isOpen
            {
                collisionMask = .WORLD
                //startAnimation(animAction: doorClosed!, animKey: "close", sprite: sprite!, name: self.name)
            }
            else
            {
                collisionMask = .NONE
                //startAnimation(animAction: doorOpen!, animKey: "open", sprite: sprite!, name: self.name)
            }
            
            isOpen = !isOpen
        }
        i += 1
    }
}
