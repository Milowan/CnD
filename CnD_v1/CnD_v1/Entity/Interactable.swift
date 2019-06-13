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
    
    init (x : Int, y : Int, s : SKSpriteNode)
    {
        super.init(x : x, y : y, s : s, m : .INTERACTABLE)
    }
    
}
