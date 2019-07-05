//
//  GreaterSkeleton.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-28.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation

import SpriteKit

class GreaterSkeleton : Enemy
{
    init (x : Int, y : Int, z : Int, s : SKSpriteNode)
    {
        var stats = [Int]()
        
        //dmg
        stats.append(6)
        //ats
        stats.append(10)
        //def
        stats.append(3)
        //evs
        stats.append(2)
        //prs
        stats.append(4)
        //hp
        stats.append(25)
        
        super.init(x : x, y : y, z : z, s : s, st : stats, str : "Greater Skeleton")
    }
}
