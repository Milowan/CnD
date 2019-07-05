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
    var player : Player?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init()
    {
        super.init()
    }
    
    func aTextField(t: String)
    {
        self.removeAllChildren()
        let myLabel = SKLabelNode(fontNamed: "Pixeled")
        myLabel.fontSize = 15
        myLabel.text = t
        self.addChild(myLabel)
    }
    
    func aHarmfulText(t: String) -> SKNode
    {
        self.removeAllChildren()
        let myLabel:SKLabelNode = SKLabelNode(fontNamed: "Pixeled")
        myLabel.fontSize = 10
        myLabel.fontColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        myLabel.text = t
        self.addChild(myLabel)
        return myLabel
    }
    
    func aHitText(t: String)
    {
        self.removeAllChildren()
        let myLabel:SKLabelNode = SKLabelNode(fontNamed: "Pixeled")
        myLabel.fontSize = 10
        myLabel.fontColor = UIColor(displayP3Red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        myLabel.text = t
        self.addChild(myLabel)
    }
}
