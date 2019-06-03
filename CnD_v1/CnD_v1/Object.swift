//
//  Object.swift
//  CnD
//
//  Created by Gavin McGuire on 2019-06-02.
//  Copyright © 2019 trios. All rights reserved.
//

import Foundation


//parent for entity, this class acts as the base
//for anything that might need to update (check for input or react to game logic)
class Object
{
    var pos : Pos
    var width: Int
    var height: Int
    
    init(x : Int, y : Int, w : Int, h : Int)
    {
        pos = Pos(xX : x, yY : y)
        width = w
        height = h
    }
    
    func draw()
    {}
    
    func update()
    {}
}
