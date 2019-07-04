//
//  Map.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-07-04.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit

class Map : GameMenu
{
    var mapScene : SKNode?
    
    var deltaY : CGFloat?
    var animSpeed : CGFloat?
    var baseY : CGFloat = 400
    
    override init(p: Player)
    {
        mapScene = GameScene.mapChild!
        super.init(p: p)
        mapScene!.position.x = playerRef.sprite!.position.x
        mapScene!.position.y = baseY
        deltaY = mapScene!.position.y - playerRef.sprite!.position.y
        animSpeed = deltaY! / 10
    }
    
    override func openMenu()
    {
        mapScene!.position.x = playerRef.sprite!.position.x
        if mapScene!.position.y > playerRef.sprite!.position.y
        {
            mapScene!.position.y -= animSpeed!
        }
        else
        {
            animDone = true
            mapScene!.position.y = playerRef.sprite!.position.y
        }
    }
    
    override func closeMenu()
    {
        mapScene!.position.x = playerRef.sprite!.position.x
        if mapScene!.position.y < baseY
        {
            mapScene!.position.y += animSpeed!
        }
        else
        {
            animDone = true
        }
    }
}
