//
//  Collectable.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-06.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit


class Collectable : Interactable
{
    var item : Item
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode, i : Item)
    {
        item = i
        super.init (x : x, y : y, z : z, s : s)
    }
    
    override func act()
    {
        item.player = player
        player!.inventory!.contents.append(item)
        collisionMask = .NONE
    }
}
