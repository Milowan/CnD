//
//  Chest.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-07-04.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Chest : Collectable
{
    var gameScene : GameScene?
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode, i : Item)
    {
        super.init(x : x, y : y, z : z, s : s, str : "Chest", i : i)
    }
    
    override func act()
    {
        item.player = player
        player!.inventory!.contents.append(item)
        self.sprite?.removeFromParent()
        let sprite = SKSpriteNode(imageNamed: "chest_open")
        sprite.position.x = CGFloat(self.pos.x)
        sprite.position.y = CGFloat(self.pos.y)
        sprite.zPosition = 6
        gameScene!.addChild(sprite)
    }
}
