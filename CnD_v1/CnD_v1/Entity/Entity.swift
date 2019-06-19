//
//  Entity.swift
//  CnD
//
//  Created by Gavin McGuire on 2019-06-02.
//  Copyright © 2019 trios. All rights reserved.
//

import Foundation
import SpriteKit

enum collisionType
{
    case WORLD
    case PLAYER
    case INTERACTABLE
    case ENEMY
    case NONE
}

class Entity
{
    
    var collisionMask : collisionType
    var pos : Pos
    var sprite : SKSpriteNode?
    
    
    init(x : Int, y : Int, z : Int, s : SKSpriteNode, m : collisionType)
    {
        collisionMask = m
        s.zPosition = CGFloat(z)
        pos = Pos(xX : x, yY : y, zZ: z)
        sprite = s
    }
    
    
    init (x : Int, y : Int, z : Int, m : collisionType)
    {
        collisionMask = m
        pos = Pos(xX : x, yY : y, zZ: z)
    }
    
    
    func draw()
    {}
    
    func update()
    {}
    
    func collision (response : Entity)
    {}
}


extension Entity : Equatable
{
    static func == (lhs : Entity, rhs : Entity) -> Bool
    {
        return
            lhs.collisionMask == rhs.collisionMask &&
                lhs.pos == rhs.pos &&
                lhs.sprite == rhs.sprite
    }
}
