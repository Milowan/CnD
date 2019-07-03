//
//  Item.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-06-18.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Item
{
    var sprite: SKSpriteNode
    var player : Player?
    
    init(s: ISNode)
    {
        sprite = s
        sprite.isUserInteractionEnabled = true
    }
    
    func menu()
    {
        
    }
}
