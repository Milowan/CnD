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
    let numButtons = 5
    var buttons = [BSNode]()
    var currentLevel: Int = 0
    
    static var view: SKView?
    static var rows: Int?
    static var columns: Int?
    static var gridSize: Int?
    
    var pool = [Entity]()
    
    override init (size : CGSize)
    {
        GameScene.gridSize = Int(size.width / 25)
        GameScene.rows = Int(size.height) / GameScene.gridSize!
        GameScene.columns = Int(size.width) / GameScene.gridSize!
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
        let x = 0
        let y = 0
        let z = 15
        addButtons()
        addEntity(entity : Player(x: x, y: y, z: z, s: SKSpriteNode(imageNamed: "knight iso char_idle_0"), buttons: buttons))
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
    
    func addButtons()
    {
        var i = 0
        while i < numButtons
        {
            if i == 0
            {
                buttons.append(BSNode(imageNamed: "arrow_left"))
            }
            if i == 1
            {
                buttons.append(BSNode(imageNamed: "arrow_right"))
            }
            if i == 2
            {
                buttons.append(BSNode(imageNamed: "arrow_up"))
            }
            if i == 3
            {
                buttons.append(BSNode(imageNamed: "arrow_down"))
            }
            if i == 4
            {
                buttons.append(BSNode(imageNamed: "btn_interact"))
            }
            addChild(buttons[i])
            i += 1
        }
        
        
        
    }
    
    func addEntity(entity : Entity)
    {
        pool.append(entity)
        addChild(entity.sprite! as SKSpriteNode)
    }
    
    
    override func update(_  currentTime : TimeInterval)
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
