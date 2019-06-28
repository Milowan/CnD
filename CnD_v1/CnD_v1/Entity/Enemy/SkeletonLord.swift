//
//  SkeletonLord.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-28.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class SkeletonLord : Boss
{
    init (x : Int, y : Int, z : Int, s : SKSpriteNode)
    {
        var stats = [Int]()
    
        //dmg
        stats.append(9)
        //ats
        stats.append(12)
        //def
        stats.append(3)
        //evs
        stats.append(8)
        //prs
        stats.append(10)
        //hp
        stats.append(50)
        //spDMG
        stats.append(15)
        //spATS
        stats.append(1)
        
        super.init(x : x, y : y, z : z, s : s, st : stats)
    }
}
