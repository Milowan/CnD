//
//  Extensions.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-06-19.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

extension SKTexture
{
    convenience init(pixelImageNamed: String)
    {
        self.init(imageNamed: pixelImageNamed)
        self.filteringMode = .nearest
    }
    
}

extension SKNode
{
    func actionForKeyIsRunning(key: String) -> Bool
    {
        if self.action(forKey: key) != nil
        {
            return true
        } else
        {
            return false
        }
    }
}
