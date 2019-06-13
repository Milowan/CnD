//
//  GameScene.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-06-02.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import SpriteKit


class GameScene: SKScene
{
    
    var currentLevel: Int = 0
    
    override func didMove(to view: SKView)
    {
        backgroundColor = SKColor.black
    }
    
    class func level(levelNum: Int) -> GameScene?
    {
        let scene = GameScene(fileNamed: "LevelScene_\(levelNum)")!
        scene.currentLevel = levelNum
        scene.scaleMode = .aspectFill
        return scene
    }
}
