//
//  Chest.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-07-04.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Chest : Collectable
{
    override func act()
    {
        player!.inventory!.contents.append(item!)
        item = nil
        self.sprite = SKSpriteNode(imageNamed: <#T##String#>)
    }
}
