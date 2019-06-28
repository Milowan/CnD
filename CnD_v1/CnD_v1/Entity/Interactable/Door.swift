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
    
    var i : Int
    override init (x: Int, y: Int, z: Int, s: SKSpriteNode)
    {
        isOpen = false
        i = 0
        super.init(x: x, y: y, z: z, s: s)
        
        collisionMask = .WORLD
    }
    
    override func act()
    {
        i %= 2
        if i == 0
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
        i += 1
    }
}
