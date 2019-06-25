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
    
    var tileSet: SKTileSet?
    typealias TileCoordinates = (column: Int, row: Int)
    var tempPoint: CGPoint?
    var tempX: Int?
    var tempY: Int?
    
    var customBGColor = UIColor(red: (22/255), green: (19/255), blue: (24/255), alpha: 1)
    
    var edgeLimits = SKTileMapNode()
    static var view: SKView?
    static var rows: Int?
    static var columns: Int?
    static var gridSize: Int?
    
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
        setTextures()
    }
    
    convenience override init()
    {
        self.init()
    }
    
    override func didMove(to view: SKView)
    {
//        for node in self.children
//        {
//            if node.name == "FloorAndBG"
//            {
//                if let someTileNode:SKTileMapNode = node as? SKTileMapNode
//                {
//                    edgeLimits = someTileNode
//                }
//                break
//            }
//        }
        self.backgroundColor = customBGColor
        GameScene.view = view
        
        let x = -15
        let y = -200
        let z = 8
        
        createLever()
        createPressPlates()
        createGemDias()
        createChests()
        setupDoors()
        createWallCollisions()
        addEntity(entity : Player(x: x, y: y, z: z, s: SKSpriteNode(imageNamed: "knight iso char_idle_0")))
        addEntity(entity : World(bottom: -64, left : -47, top : 50, right : 0))
        setupCamera(player: GameScene.player!.sprite!)
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
        
//        let xInset = min((view?.bounds.width)!/2 * camera.xScale, edgeLimits.frame.width/2)
//        let yInset = min((view?.bounds.height)!/2 * camera.yScale, edgeLimits.frame.height/2)
//        let constraintRect = edgeLimits.frame.insetBy(dx: xInset, dy: yInset)
//        let xRange = SKRange(lowerLimit: constraintRect.minX, upperLimit: constraintRect.maxX)
//        let yRange = SKRange(lowerLimit: constraintRect.minY, upperLimit: constraintRect.maxY)
//        let edgeConstraint = SKConstraint.positionX(xRange, y: yRange)
//        edgeConstraint.referenceNode = edgeLimits
        
        camera.constraints = [playerConstraint]
    }
    
    func setTextures()
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
    }
    
    func tile(in tileMap: SKTileMapNode, at coordinates: TileCoordinates) -> SKTileDefinition?
    {
        tempPoint = tileMap.centerOfTile(atColumn: coordinates.column, row: coordinates.row)
        tempX = Int(tempPoint!.x)
        tempY = Int(tempPoint!.y)
        return tileMap.tileDefinition(atColumn: coordinates.column, row: coordinates.row)
    }
    
    func setupDoors()
    {
        
    }
    
    func createDoors()
    {
        var i: Int = 0
        guard let doorMap = childNode(withName: "Interactable_Door") as? SKTileMapNode else {return}
        for row in 0..<doorMap.numberOfRows
        {
            for column in 0..<doorMap.numberOfColumns
            {
                guard tile(in: doorMap, at: (column, row)) != nil else {continue}
                let tempDoor = Door(x: tempX! + 8, y: tempY! + 24, z: 5, s: SKSpriteNode(imageNamed: "door_bg"), id: i)
                addEntity(entity: tempDoor)
                
                i += 1
                doorMap.removeFromParent()
            }
        }
    }
    
    func createLever()
    {
        guard let leverMap = childNode(withName: "Interactable_wLever") as? SKTileMapNode else {return}
        for row in 0..<leverMap.numberOfRows
        {
            for column in 0..<leverMap.numberOfColumns
            {
                guard tile(in: leverMap, at: (column, row)) != nil else {continue}
                addEntity(entity: Interactable(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "switch_wall_on")))
                
                leverMap.removeFromParent()
            }
        }
    }
    
    func createPressPlates()
    {
        guard let plateMap = childNode(withName: "Interactable_pPlate") as? SKTileMapNode else {return}
        for row in 0..<plateMap.numberOfRows
        {
            for column in 0..<plateMap.numberOfColumns
            {
                guard tile(in: plateMap, at: (column, row)) != nil else {continue}
                addEntity(entity: Interactable(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "floor")))
                
                plateMap.removeFromParent()
            }
        }
    }
    
    func createGemDias()
    {
        guard let gemMap = childNode(withName: "Interactable_GemDias") as? SKTileMapNode else {return}
        for row in 0..<gemMap.numberOfRows
        {
            for column in 0..<gemMap.numberOfColumns
            {
                guard tile(in: gemMap, at: (column, row)) != nil else {continue}
                addEntity(entity: Interactable(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "switch_floor_on")))
                
                gemMap.removeFromParent()
            }
        }
    }
    
    func createWallCollisions()
    {
        guard let colMap1 = childNode(withName: "TopWalls") as? SKTileMapNode else {return}
        for row in 0..<colMap1.numberOfRows
        {
            for column in 0..<colMap1.numberOfColumns
            {
                guard tile(in: colMap1, at: (column, row)) != nil else {continue}
                addEntity(entity: World(bottom: tempY! - 8, left: tempX! - 8, top: tempY! + 8, right: tempX! + 8))
            }
        }
        guard let colMap2 = childNode(withName: "BotCollisions") as? SKTileMapNode else {return}
        for row in 0..<colMap2.numberOfRows
        {
            for column in 0..<colMap2.numberOfColumns
            {
                guard tile(in: colMap2, at: (column, row)) != nil else {continue}
                addEntity(entity: World(bottom: tempY! - 8, left: tempX! - 8, top: tempY! + 8, right: tempX! + 8))
                
                colMap2.removeFromParent()
            }
        }
    }
    
    func createChests()
    {
        guard let chestMap = childNode(withName: "Interactable_Chest") as? SKTileMapNode else {return}
        for row in 0..<chestMap.numberOfRows
        {
            for column in 0..<chestMap.numberOfColumns
            {
                guard tile(in: chestMap, at: (column, row)) != nil else {continue}
                addEntity(entity: Interactable(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "chest_closed")))
                
                chestMap.removeFromParent()
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
