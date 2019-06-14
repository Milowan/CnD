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
    
    static var view : SKView?
    
    var pool = [Entity]()
    
    override init (size : CGSize)
    {
        super.init(size : size)
    }
    
    required init?(coder : NSCoder)
    {
        super.init(coder : coder)
    }
    
    convenience override init()
    {
        self.init()
    }
    
    override func didMove(to view: SKView)
    {
        backgroundColor = SKColor.black
        GameScene.view = view
        let x = Int(size.width / 2)
        let y = Int(size.height / 2)
        let z = 15
        addEntity(entity : Player(x: x, y: y, z: z, s: SKSpriteNode(imageNamed: "knight iso char_idle_0")))
    }
    
    class func level(levelNum: Int) -> GameScene?
    {
        let scene = GameScene(fileNamed: "LevelScene_\(levelNum)")!
        
        scene.currentLevel = levelNum
        scene.scaleMode = .aspectFill
        return scene
    }
    
    func setupCamera(player: SKNode)
    {
        guard let camera = camera else {return}
        
        let zeroDistance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(zeroDistance, to: player)
        
        camera.constraints = [playerConstraint]
    }
    
    
    func addEntity(entity : Entity)
    {
        pool.append(entity)
        addChild(entity.sprite! as SKSpriteNode)
    }
    
    
    func update()
    {
        for entity in pool
        {
            entity.update()
        }
        
        collision()
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
