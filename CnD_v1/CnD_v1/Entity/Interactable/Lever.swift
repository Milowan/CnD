//
//  Lever.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-24.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Lever : Interactable
{
    var door : Adoor
    var altSprite : SKSpriteNode
    var tmpz : CGFloat
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode, d : Adoor)
    {
        door = d
        altSprite = SKSpriteNode(imageNamed : "switch_wall_off")
        s.addChild(altSprite)
        tmpz = 1
        altSprite.zPosition = -1
        super.init(x : x, y : y, z : z, s : s)
    }
    
    override func act()
    {
        let tmp = altSprite.zPosition
        altSprite.zPosition = tmpz
        tmpz = tmp
        door.toggleState()
    }
}
