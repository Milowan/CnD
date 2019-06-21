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
    var iD: Int
    init (x: Int, y: Int, z: Int, s: SKSpriteNode, id: Int)
    {
        iD = id
        super.init(x: x, y: y, z: z, s: s)
    }
    
    override func act()
    {
        
    }
}
