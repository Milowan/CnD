//
//  Sword.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-27.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Sword : Gear
{
    let baseDamage = 5
    let baseSpeed = 2
    
    var player : Player
    
    init (p : Player, st : Stats, sp : ISNode)
    {
        player = p
        super.init(st : st, sp : sp)
    }
}
