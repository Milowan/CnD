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
    
    var hud = HUD()
    
    var edgeLimits = SKTileMapNode()
    static var view: SKView?
    static var rows: Int?
    static var columns: Int?
    static var gridSize: Int?
    static var invChild: SKNode?
    static var mapChild: SKNode?
    
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
        GameScene.mapChild = childNode(withName: "Map")
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
        let tempPlayer = Player(x: x, y: y, z: z, s: SKSpriteNode(imageNamed: "knight iso char_idle_0"), h : hud)
        addEntity(entity : tempPlayer)
        levelGenerator!.generate(p: tempPlayer)
        hud.player = tempPlayer
        setupHUD()
        setupCamera(player: tempPlayer.sprite!)
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
            addChild(entity.sprite! as! SKSpriteNode)
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
    
    func setupHUD()
    {
        hud.position.x = hud.player!.sprite!.position.x + 30
        hud.position.y = (hud.player!.sprite!.position.y + 4)
        hud.zPosition = 20
        camera?.addChild(hud)
        hud.aTextField(t: "Work In Progress ... Beta Footage")
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
                    enemy.update()
                }
            }
            if let player = entity as? Player
            {
                player.update()
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
                        entity.collision(response : response)
                }
            }
        }
    }
    
    
}
