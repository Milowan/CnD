//
//  HUD.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-07-02.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class HUD : SKNode
{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func aTextField(t: String)
    {
        let myLabel:SKLabelNode = SKLabelNode(fontNamed: "Pixeled")
        myLabel.fontSize = 25
        myLabel.text = t
        self.addChild(myLabel)
    }
}