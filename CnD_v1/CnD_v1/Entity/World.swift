//
//  World.swift
//  CnD
//
//  Created by Gavin McGuire on 2019-06-03.
//  Copyright © 2019 trios. All rights reserved.
//

import Foundation
import SpriteKit

class World : Entity
{
    
    
    init (x : Int, y : Int, z : Int, w : Int, h : Int)
    {
        
        super.init (x : x, y : y, z : z, m : .WORLD)
    }
}
