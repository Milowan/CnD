//
//  Entity.swift
//  CnD
//
//  Created by Gavin McGuire on 2019-06-02.
//  Copyright © 2019 trios. All rights reserved.
//

import Foundation
import SpriteKit


class Entity : Object
{
    
    override init(x : Int, y : Int, w : Int, h: Int, s : SKSpriteNode)
    {
        super.init(x : x, y : y, w : w, h : h, s : s)
    }
    
    func collision (response : Entity)
    {}
}
