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
    case COLLECTABLE
}

class Entity
{
    
    var collisionMask : collisionType
    
    var pos : Pos
    var width : Int
    var height : Int
    var sprite : SKSpriteNode
    
    
    init(x : Int, y : Int, w : Int, h: Int, s : SKSpriteNode, m : collisionType)
    {
        collisionMask = m
        pos = Pos(xX : x, yY : y)
        width = w
        height = h
        sprite = s
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
                lhs.width == rhs.width &&
                lhs.height == rhs.height &&
                lhs.sprite == rhs.sprite
    }
}
