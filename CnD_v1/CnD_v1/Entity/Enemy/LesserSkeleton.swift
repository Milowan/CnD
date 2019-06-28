//
//  LesserSkeleton.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-28.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class LesserSkeleton : Enemy
{
    init (x : Int, y : Int, z : Int, s : SKSpriteNode)
    {
        var stats = [Int]()
        
        //dmg
        stats.append(3)
        //ats
        stats.append(7)
        //def
        stats.append(2)
        //evs
        stats.append(1)
        //prs
        stats.append(2)
        //hp
        stats.append(10)
        
        super.init(x : x, y : y, z : z, s : s, st : stats)
    }
}
