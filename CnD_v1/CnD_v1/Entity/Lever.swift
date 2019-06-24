//
//  Lever.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-24.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Lever : Interactable
{
    var door : Adoor?
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode, d : Adoor)
    {
        door = d
        
        super.init(x : x, y : y, z : z, s : s)
    }
    
    override func act()
    {
        door!.toggleState()
    }
}
