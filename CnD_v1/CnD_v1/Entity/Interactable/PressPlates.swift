//
//  PressPlates.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-06-21.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import SpriteKit
import Foundation

class PressPlates : Entity
{
    
    var rocked : Bool
    var stood : Bool
    var door : Adoor
    var altSprite : SKSpriteNode
    var tmpz : CGFloat
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode, d : Adoor)
    {
        door = d
        rocked = false
        stood = false
        altSprite = SKSpriteNode(imageNamed : "floor_sunken_top")
        tmpz = 1
        super.init (x : x, y : y, z : z, s : s, m : .NONE)
        sprite!.addChild(altSprite)
        altSprite.zPosition = -1
    }
    
    func act()
    {
        if !rocked
        {
            if !stood
            {
                let tmp = altSprite.zPosition
                altSprite.zPosition = tmpz
                tmpz = tmp
                door.toggleState()
                stood = true
            }
        }
    }
}
