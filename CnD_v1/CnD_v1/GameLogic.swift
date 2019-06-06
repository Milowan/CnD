//
//  GameLogic.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-04.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation


class GameLogic
{
    var pool = [Entity]()
    
    init()
    {
        
    }
    
    func update()
    {
        for entity in pool
        {
            entity.update()
        }
    }
    
    func collision()
    {
        for entity in pool
        {
            for response in pool
            {
                if entity != response
                {
                    entity.collision(response : response)
                    
                }
            }
        }
    }
}
