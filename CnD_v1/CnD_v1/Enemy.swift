//
//  Enemy.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-25.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy : Entity
{
    
    
    init(x : Int, y : Int, z : Int, s : SKSpriteNode)
    {
        super.init(x : x, y : y, z : z, s : s, m : .ENEMY)
    }
}
