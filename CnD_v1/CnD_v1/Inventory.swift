//
//  Inventory.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-25.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Inventory : GameMenu
{
    var invScene : SKNode?
    
    var deltaY : CGFloat?
    var animSpeed : CGFloat?
    var baseY : CGFloat = 400
    
    override init(p: Player)
    {
        invScene = GameScene.invChild!
        super.init(p: p)
        invScene!.position.x = playerRef.sprite!.position.x
        invScene!.position.y = baseY
        deltaY = invScene!.position.y - playerRef.sprite!.position.y
        animSpeed = deltaY! / 10
    }
    
     override func openMenu()
    {
        invScene!.position.x = playerRef.sprite!.position.x
        if invScene!.position.y >= (playerRef.sprite!.position.y + 10)
        {
            invScene!.position.y -= animSpeed!
        }
        else
        {
            animDone = true
            invScene!.position.y = (playerRef.sprite!.position.y + 10)
        }
    }
    
    override func closeMenu()
    {
        invScene!.position.x = playerRef.sprite!.position.x
        if invScene!.position.y < baseY
        {
            invScene!.position.y += animSpeed!
        }
        else
        {
            animDone = true
        }
    }
}
