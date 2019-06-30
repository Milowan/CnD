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
    var active : Bool
    var clear : Bool
    
    init(x : Int, y : Int, z : Int, s : BSNode)
    {
        active = false
        clear = false
        interactable = nil
        s.isUserInteractionEnabled = true
        super.init(x : x, y : y, z : z, s : s, m : .NONE)
        (self.sprite as! BSNode).button = self
    }
    
    override func update()
    {
        
    }
    
    func act()
    {
        
    }
}
