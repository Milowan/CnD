//
//  Gem.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-30.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Gem : Item
{
    override func menu()
    {
        // if let dais = player.interact.interactable! as? Dais
        // {
        //      place gem option
        // }
    }
    
    func place(d : Dais)
    {
        if !d.hasGem
        {
            player!.removeGem()
            
            d.activate()
        }
    }
    
    func examine()
    {
        
    }
}
