//
//  Pos.swift
//  CnD
//
//  Created by Gavin McGuire on 2019-06-02.
//  Copyright © 2019 trios. All rights reserved.
//

import Foundation


class Pos
{
    var x : Int
    var y : Int
    var z : Int
    
    init(xX : Int, yY: Int, zZ: Int)
    {
        x = xX
        y = yY
        z = zZ
    }
}


extension Pos : Equatable
{
    static func == (lhs : Pos, rhs : Pos) -> Bool
    {
        return
            lhs.x == rhs.x &&
                lhs.y == rhs.y
    }
}
