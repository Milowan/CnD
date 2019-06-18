//
//  Button.swift
//  CnD
//
//  Created by Gavin McGuire on 2019-06-03.
//  Copyright © 2019 trios. All rights reserved.
//

import Foundation
import SpriteKit


class Button : Entity
{
    var interactable : Interactable?
    var player : Player?
    var active : Bool
    
    init(x : Int, y : Int, z : Int, s : BSNode)
    {
        active = false
        interactable = nil
        player = nil
        s.isUserInteractionEnabled = true
        super.init(x : x, y : y, z : z, s : s, m : .NONE)
        s.button = self
    }
    
    override func update()
    {
        
    }
    
    func act()
    {
        
    }
}
