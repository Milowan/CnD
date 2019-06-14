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
    
    var pos : Pos?
    var sprite : SKSpriteNode?
    
    
    init(x : Int, y : Int, s : SKSpriteNode, m : collisionType)
    {
        collisionMask = m
        s.position = CGPoint(x : x, y : y)
        sprite = s
    }
    
    
    init (x : Int, y : Int, m : collisionType)
    {
        collisionMask = m
        pos = Pos(xX : x, yY : y)
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
