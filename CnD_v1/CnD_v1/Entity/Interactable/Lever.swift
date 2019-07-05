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
    var isOn : Bool?
    var onSprite : SKSpriteNode?
    var offSprite : SKSpriteNode?
    
    init (x : Int, y : Int, z : Int, s : SKSpriteNode, d : Adoor)
    {
        door = d
        isOn = false
        onSprite = SKSpriteNode(imageNamed: "switch_wall_off")
        offSprite = SKSpriteNode(imageNamed: "switch_wall_on")
        s.addChild(offSprite!)
        super.init(x : x, y : y, z : z, s : s, str : "Lever")
    }
    
    override func act()
    {
        if !isOn!
        {
            
            sprite!.removeAllChildren()
            door!.toggleState()
            sprite!.addChild(onSprite!)
            isOn = true
        }
        else
        {
            sprite!.removeAllChildren()
            door!.toggleState()
            sprite!.addChild(offSprite!)
            isOn = false
        }
    }
}
