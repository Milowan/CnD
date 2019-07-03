//
//  Helmet.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-27.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Helmet : Gear
{
    let baseDef = 2
    let basePrecision = 3
    
    init (p : Player, st : Stats, sp : ISNode)
    {
        
        super.init(st : st, sp : sp)
        
        self.player = p
    }
}
