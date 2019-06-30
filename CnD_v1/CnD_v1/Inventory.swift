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
    var isOpen = false
    var playerRef : Player
    let baseX = CGFloat(0)
    let baseY = CGFloat(500)
    
    init(p: Player)
    {
        invScene = GameScene.invChild!
        playerRef = p
        i = 0
        invScene.position.x = baseX
        invScene.position.y = baseY
    }
    
    func act()
    {
        i %= 2
        if i == 0
        {
            if isOpen
            {
                closeInv()
            }
            else
            {
                openInv()
            }
            isOpen = !isOpen
        }
        i += 1
    }
    
    func openInv()
    {
        invScene.position.x = playerRef.sprite!.position.x
        invScene.position.y = playerRef.sprite!.position.y
    }
    
    func closeInv()
    {
        invScene.position.x = baseX
        invScene.position.y = baseY
    }
}
