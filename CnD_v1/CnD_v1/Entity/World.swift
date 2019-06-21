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
    init (bottom : Int, left : Int, top : Int, right : Int)
    {
        var x : Int
        var y : Int
        let width = right - left
        let height = top - bottom
        
        x = left + (width / 2)
        y = bottom + (height / 2)
        
        
        super.init (x : x, y : y, m : .WORLD)
        
        self.width = width
        self.height = height
    }
}
