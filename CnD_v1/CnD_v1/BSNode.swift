//
//  ButtonSPriteNode.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-14.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit


class BSNode : SKSpriteNode
{
    var button : Button?
    
    override func touchesBegan (_ touches : Set<UITouch>, with event : UIEvent?)
    {
        let button = self.button!
        
        for touch in touches
        {
            let sprite = button.sprite!
            let touchP = touch.location(in : GameScene.view!)
            
            if  touchP.x > sprite.position.x && touchP.x < sprite.position.x + sprite.size.width &&
                touchP.y > sprite.position.y && touchP.y < sprite.position.y + sprite.size.height
            {
                button.active = true
            }
        }
        
    }
    
    override func touchesMoved(_ touches : Set<UITouch>, with event : UIEvent?)
    {
        
    }
    
    override func touchesEnded(_ touches : Set<UITouch>, with event : UIEvent?)
    {
        let button = self.button!
        button.active = false
    }
    
}
