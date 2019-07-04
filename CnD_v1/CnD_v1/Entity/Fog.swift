//
//  Fog.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-07-03.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation

class Fog : Entity
{

    
    override func collision(response: Entity)
    {
    
        if response.collisionMask == .PLAYER
        {
            let a = self.sprite!
            let aBottom = self.pos.y - Int(a.frame.height / 2)
            let aTop = self.pos.y - Int(a.frame.height / 4)
            let aLeft = self.pos.x - Int((a.frame.width / 4) / 2)
            let aRight = self.pos.x + Int((a.frame.width / 4) / 2)
            
            var bBottom : Int
            var bTop : Int
            var bLeft : Int
            var bRight : Int
            
            bBottom = response.pos.y - Int(response.sprite!.frame.height / 2)
            bTop = response.pos.y + Int(response.sprite!.frame.height / 2)
            bLeft = response.pos.x - Int(response.sprite!.frame.width / 2)
            bRight = response.pos.x + Int(response.sprite!.frame.width / 2)
            
            if  aBottom <= bTop - 15 &&
                aTop >= bBottom + 15 &&
                aLeft <= bRight &&
                aRight >= bLeft
            {
                
            }
        }
    }
}
