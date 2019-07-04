//
//  Options.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-07-04.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Options : SKLabelNode
{
    var released = true
    
    var item : Item?
    
    required init?(coder : NSCoder)
    {
        super.init(coder : coder)
    }
    
    override init()
    {
        super.init()
        
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan (_ touches : Set<UITouch>, with event : UIEvent?)
    {
        if released
        {
            if let item = self.item
            {
                item.handleInput()
            }
            
            released = false
        }
    }
    
    override func touchesMoved(_ touches : Set<UITouch>, with event : UIEvent?)
    {
        
    }
    
    override func touchesEnded(_ touches : Set<UITouch>, with event : UIEvent?)
    {
        released = true
    }
}
