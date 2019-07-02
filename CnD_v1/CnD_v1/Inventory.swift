//
//  Inventory.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-25.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Inventory
{
    var contents : [Item]?
    var invScene: SKNode
    var i : Int
    var isOpen : Bool?
    var animDone : Bool?
    var playerRef : Player
    var deltaY : CGFloat
    var animSpeed : CGFloat
    let baseY = CGFloat(400)
    
    init(p: Player)
    {
        invScene = GameScene.invChild!
        playerRef = p
        i = 0
        invScene.position.x = playerRef.sprite!.position.x
        invScene.position.y = baseY
        deltaY = invScene.position.y - playerRef.sprite!.position.y
        animSpeed = deltaY / 10
        isOpen = true
        animDone = true
    }
    
    func update()
    {
        if !animDone!
        {
            if isOpen!
            {
                closeInv()
            }
            else
            {
                openInv()
            }
        }
    }
    
    func act()
    {
        animDone = false
        isOpen = !isOpen!
    }
    
    func openInv()
    {
        if invScene.position.y > playerRef.sprite!.position.y
        {
            invScene.position.y -= animSpeed
        }
        else
        {
            animDone = true
        }
    }
    
    func closeInv()
    {
        if invScene.position.y < baseY
        {
            invScene.position.y += animSpeed
        }
        else
        {
            animDone = true
        }
    }
}
