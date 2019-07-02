//
//  Gear.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-04.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Gear : Item
{
    var stats : Stats
    
    init (st : Stats, sp : ISNode)
    {
        stats = st
        super.init(s : sp)
    }
}
