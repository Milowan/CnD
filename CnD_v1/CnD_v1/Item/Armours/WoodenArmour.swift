//
//  WoodenArmour.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-07-03.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class WoodenArmour : Armour
{
    init (p : Player)
    {
        let stats = Stats(s : 1, d : 1, c : 1)
        
        super.init(p : p, st : stats, sp : ISNode(imageNamed: "sword_01a"))
    }
}
