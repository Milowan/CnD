//
//  Interactable.swift
//  CnD
//
//  Created by Gavin McGuire on 2019-06-03.
//  Copyright © 2019 trios. All rights reserved.
//

import Foundation
import SpriteKit

class Interactable : Entity
{
    
    var player : Player?
    
    init (x : Int, y : Int, z: Int, s : SKSpriteNode)
    {
        super.init(x: x, y: y, z: z, s: s, m: .INTERACTABLE)
    }
    
    func act()
    {
        
    }
    
}
