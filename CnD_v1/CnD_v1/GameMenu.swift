//
//  GameMenu.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-07-04.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit


class GameMenu
{
    var contents = [Item]()
    var isOpen : Bool
    var animDone : Bool?
    var playerRef : Player
    
    
    init(p: Player)
    {
        playerRef = p
        isOpen = true
        animDone = true
    }
    
    func openMenu() {}
    func closeMenu() {}
    
    func update()
    {
        
        if !animDone!
        {
            if isOpen
            {
                closeMenu()
            }
            else
            {
                openMenu()
            }
        }
    }
    
    func act()
    {
        animDone = false
        isOpen = !isOpen
    }
}
