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
        
        addButtons()
        createLever()
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
//
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
    
    func createLever()
    {
        guard let leverMap = childNode(withName: "Interactable_wLever") as? SKTileMapNode else {return}
        for row in 0..<leverMap.numberOfRows
        {
            for column in 0..<leverMap.numberOfColumns
            {
                guard tile(in: leverMap, at: (column, row)) != nil else {continue}
            
            //let lever = Interactable(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "lever_wall_up"))
            
            addEntity(entity: Interactable(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "switch_wall_on")))
            
            leverMap.removeFromParent()
                
            }
        }
//        let doorMap = childNode(withName: "Doorways") as? SKTileMapNode
//        doorMap?.removeFromParent()
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
