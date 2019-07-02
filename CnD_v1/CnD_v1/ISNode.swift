//
//  ISNode.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-30.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class ISNode : SKSpriteNode
{
    var item : Item?
    
    override func touchesBegan (_ touches : Set<UITouch>, with event : UIEvent?)
    {
        item!.menu()
    }
    
    override func touchesMoved(_ touches : Set<UITouch>, with event : UIEvent?)
    {
        
    }
    
    override func touchesEnded(_ touches : Set<UITouch>, with event : UIEvent?)
    {
    }
    
}
