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
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode)
    {
        isOpen = false
        
        super.init(x : x, y : y, z : z, s : s, m : .WORLD)
    }
    
    func toggleState()
    {
        if isOpen
        {
            collisionMask = .WORLD
        }
        else
        {
            collisionMask = .NONE
        }
        
        isOpen = !isOpen
    }
}
