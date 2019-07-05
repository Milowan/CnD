//
//  Rock.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-07-03.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Rock : Item
{
    
    init ()
    {
        super.init(s : ISNode(imageNamed : "gem_01i"))
    }
    
    override func menu()
    {
        let place = Options()
        player!.inventory!.invScene!.addChild(place)
    }
    
    override func handleInput()
    {
        
    }
    
    func place()
    {
        if player!.onPlate
        {
            player!.removeRock()
            
            player!.plate!.rocked = true
        }
    }
}
