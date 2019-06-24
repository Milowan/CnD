//
//  Door.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-06-18.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Door: Interactable
{
    var isOpen : Bool
    override init (x: Int, y: Int, z: Int, s: SKSpriteNode)
    {
        isOpen = false
        
        super.init(x: x, y: y, z: z, s: s)
        
        collisionMask = .WORLD
    }
    
    override func act()
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
