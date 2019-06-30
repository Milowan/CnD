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
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode, d : Adoor)
    {
        door = d
        rocked = false
        stood = false
        super.init (x : x, y : y, z : z, s : s, m : .NONE)
    }
    
    func act()
    {
        if !rocked
        {
            if !stood
            {
                door.toggleState()
                stood = true
            }
        }
    }
}
