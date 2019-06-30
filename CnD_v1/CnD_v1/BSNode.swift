//
//  BSNode.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-19.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit


class BSNode : SKSpriteNode
{
    var button : Button?
    
    override func touchesBegan (_ touches : Set<UITouch>, with event : UIEvent?)
    {
        self.button!.active = true
    }
    
    override func touchesMoved(_ touches : Set<UITouch>, with event : UIEvent?)
    {
        
    }
    
    override func touchesEnded(_ touches : Set<UITouch>, with event : UIEvent?)
    {
        self.button!.active = false
        self.button!.clear = false
    }
    
}
