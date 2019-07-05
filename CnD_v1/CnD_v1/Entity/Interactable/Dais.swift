//
//  Dais.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-24.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Dais : Interactable
{
    var oDais = [Dais]()
    
    var door : Adoor
    
    var hasGem = false
    var acted = false
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode, d : Adoor)
    {
        door = d
        
        super.init(x : x, y : y, z : z, s : s, str : "Dais")
    }
    
    override func act()
    {
        player!.inventory!.openMenu()
    }
    
    override func update()
    {
        var openDoor = true
        
        for dais in oDais
        {
            if !dais.hasGem || dais.acted
            {
                openDoor = false
            }
        }
        
        if openDoor
        {
            door.toggleState()
            
            for dais in oDais
            {
                dais.acted = true
            }
            
            acted = true
        }
    }
    
    func activate()
    {
        hasGem = true
    }
}
