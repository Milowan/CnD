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
    
    var levelGenerator : LevelGenerator?
    
    var tileSet: SKTileSet?
    typealias TileCoordinates = (column: Int, row: Int)
    var tempPoint: CGPoint?
    
    var doorArray: [Adoor]? = []
    var customBGColor = UIColor(red: (22/255), green: (19/255), blue: (24/255), alpha: 1)
    
    var room1:[Entity] = []
    var room2:[Entity] = []
    var room3:[Entity] = []
    var room4:[Entity] = []
    var room5:[Entity] = []
    
    var edgeLimits = SKTileMapNode()
    static var view: SKView?
    static var rows: Int?
    static var columns: Int?
    static var gridSize: Int?
    static var invChild: SKNode?
    static var player: Player?
    
    var pool = [Entity]()
    
    override init (size : CGSize)
    {
        super.init(size : size)
    }
    
    required init?(coder : NSCoder)
    {
        super.init(coder : coder)
        GameScene.gridSize = Int(size.width / 50)
        GameScene.rows = Int(size.height) / GameScene.gridSize!
        GameScene.columns = Int(size.width) / GameScene.gridSize!
        GameScene.invChild = childNode(withName: "Inventory")
        setPixelTextures()
    }
    
    convenience override init()
    {
        self.init()
    }
    
    override func didMove(to view: SKView)
    {
        self.backgroundColor = customBGColor
        GameScene.view = view
        
        let x = -15
        let y = -200
        let z = 8
        levelGenerator!.generate()
        addEntity(entity : Player(x: x, y: y, z: z, s: SKSpriteNode(imageNamed: "knight iso char_idle_0")))
        setupCamera(player: GameScene.player!.sprite!)
    }
    
    func setupCamera(player: SKNode)
    {
        guard let camera = camera else {return}
        let zeroDistance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(zeroDistance, to: player)
        camera.constraints = [playerConstraint]
    }
    
    func setPixelTextures()
    {
        tileSet = SKTileSet(named: "BG Map Tiles")!
        for tileGroup in tileSet!.tileGroups
        {
            for tileRule in tileGroup.rules
            {
                for tileDefinition in tileRule.tileDefinitions
                {
                    for texture in tileDefinition.textures
                    {
                        texture.filteringMode = .nearest
                    }
                }
            }
        }
        tileSet = SKTileSet(named: "FG Map Tiles")!
        for tileGroup in tileSet!.tileGroups
        {
            for tileRule in tileGroup.rules
            {
                for tileDefinition in tileRule.tileDefinitions
                {
                    for texture in tileDefinition.textures
                    {
                        texture.filteringMode = .nearest
                    }
                }
            }
        }
        tileSet = SKTileSet(named: "BG DiagonalFloor Tiles")!
        for tileGroup in tileSet!.tileGroups
        {
            for tileRule in tileGroup.rules
            {
                for tileDefinition in tileRule.tileDefinitions
                {
                    for texture in tileDefinition.textures
                    {
                        texture.filteringMode = .nearest
                    }
                }
            }
        }
        tileSet = SKTileSet(named: "UI Map Tiles")!
        for tileGroup in tileSet!.tileGroups
        {
            for tileRule in tileGroup.rules
            {
                for tileDefinition in tileRule.tileDefinitions
                {
                    for texture in tileDefinition.textures
                    {
                        texture.filteringMode = .nearest
                    }
                }
            }
        }
        tileSet = SKTileSet(named: "UiText")!
        for tileGroup in tileSet!.tileGroups
        {
            for tileRule in tileGroup.rules
            {
                for tileDefinition in tileRule.tileDefinitions
                {
                    for texture in tileDefinition.textures
                    {
                        texture.filteringMode = .nearest
                    }
                }
            }
        }
    }

    func addEntity(entity : Entity)
    {
        pool.append(entity)
        if entity.sprite != nil
        {
            addChild(entity.sprite! as SKSpriteNode)
        }
    }
    
    func removeEntity(entity : Entity)
    {
        if let index = pool.firstIndex(of: entity)
        {
            entity.sprite!.removeFromParent()
            pool.remove(at: index)
        }
    }
    
    
    override func update(_  currentTime : TimeInterval)
    {
        for entity in pool
        {
            entity.update()
            if let enemy = entity as? Enemy
            {
                if enemy.isDespawned
                {
                    removeEntity(entity: enemy)
                }
            }
            if let collector = entity as? Collectable
            {
                if collector.item == nil
                {
                    removeEntity(entity : collector)
                }
            }
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
                    if let player = entity as? Player
                    {
                        player.collision(response : response)
                    }
                }
            }
        }
    }
    
    
}
