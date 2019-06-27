//
//  Stats.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-20.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation


class Stats
{
    var STR : Int
    var DEX : Int
    var CON : Int
    var DMG : Float
    
    init (s : Int, d : Int, c : Int)
    {
        STR = s
        DEX = d
        CON = c
        DMG = Float(STR) * 1.5
    }
}
