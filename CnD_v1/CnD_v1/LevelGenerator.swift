//
//  LevelGenerator.swift
//  CnD_v1
//
//  Created by Gavin McGuire on 2019-06-28.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import Foundation
import SpriteKit


class LevelGenerator
{
    
    var tileSet: SKTileSet?
    typealias TileCoordinates = (column: Int, row: Int)
    var tempPoint: CGPoint?
    var tempX: Int?
    var tempY: Int?
    
    var gameScene : GameScene?
    var inventory : Inventory?
    
    init()
    {
    }
    
    func level(levelNum: Int) -> GameScene?
    {
        let scene = GameScene(fileNamed: "LevelScene_\(levelNum)")!
        
        scene.currentLevel = levelNum
        scene.scaleMode = .aspectFill
        
        self.gameScene = scene
        
        return scene
    }
    
    func generate(p: Player)
    {
        createDoors()
        setupADoors()
        createLever()
        createPressPlates()
        createGemDias()
        createAlcoves()
        createChests()
        createEnemies()
        createWallCollisions()
        //createInventory(p : p)
    }
    
    func createInventory(p : Player)
    {
        guard let inventorySlot = gameScene!.childNode(withName: "Inventory") /*as? SKTileMapNode*/ else {return}
        guard let inventorySlots = inventorySlot.childNode(withName: "InventoryPlaceholders") as? SKTileMapNode else {return}
        for row in 0..<inventorySlots.numberOfRows
        {
            for column in 0..<inventorySlots.numberOfColumns
            {
                guard tile(in: inventorySlots, at: (column, row)) != nil else {continue}
                let slot = Slot(x : tempX!, y : tempY!, z : 16, s : SKSpriteNode(imageNamed: "emptySlot"), m : .NONE)
                p.inventory!.slots.append(slot)
                inventorySlots.removeFromParent()
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
    
    func setupADoors()
    {
        guard let doorMap = gameScene!.childNode(withName: "Interactable_aDoor") as? SKTileMapNode else {return}
        for row in 0..<doorMap.numberOfRows
        {
            for column in 0..<doorMap.numberOfColumns
            {
                guard tile(in: doorMap, at: (column, row)) != nil else {continue}
                let tempDoor = Adoor(x: tempX! + 8, y: tempY! + 16, z: 5, s: SKSpriteNode(imageNamed: "frame0000"))
                gameScene!.addEntity(entity: tempDoor)
                gameScene!.doorArray?.append(tempDoor)
                doorMap.removeFromParent()
            }
        }
    }
    
    func createDoors()
    {
        guard let doorMap = gameScene!.childNode(withName: "Interactable_Door") as? SKTileMapNode else {return}
        for row in 0..<doorMap.numberOfRows
        {
            for column in 0..<doorMap.numberOfColumns
            {
                guard tile(in: doorMap, at: (column, row)) != nil else {continue}
                let tempDoor = Door(x: tempX! + 8, y: tempY! + 16, z: 5, s: SKSpriteNode(imageNamed: "frame0000"))
                gameScene!.addEntity(entity: tempDoor)
                doorMap.removeFromParent()
            }
        }
    }
    
    func createLever()
    {
        var i = 0
        
        guard let leverMap = gameScene!.childNode(withName: "Interactable_wLever") as? SKTileMapNode else {return}
        for row in 0..<leverMap.numberOfRows
        {
            for column in 0..<leverMap.numberOfColumns
            {
                guard tile(in: leverMap, at: (column, row)) != nil else {continue}
                if i == 0
                {
                    let tempLever = Lever(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "leverParent"), d: gameScene!.doorArray![1])
                    gameScene!.addEntity(entity: tempLever)
                }
                else if i == 1
                {
                    let tempLever = Lever(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "leverParent"), d: gameScene!.doorArray![0])
                    gameScene!.addEntity(entity: tempLever)
                }
                i += 1
                leverMap.removeFromParent()
            }
        }
    }
    
    func createPressPlates()
    {
        guard let plateMap = gameScene!.childNode(withName: "Interactable_pPlate") as? SKTileMapNode else {return}
        for row in 0..<plateMap.numberOfRows
        {
            for column in 0..<plateMap.numberOfColumns
            {
                guard tile(in: plateMap, at: (column, row)) != nil else {continue}
                gameScene!.addEntity(entity: PressPlates(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "floor"), d : (gameScene!.doorArray![2])))
                plateMap.removeFromParent()
            }
        }
    }
    
    func createGemDias()
    {
        guard let gemMap = gameScene!.childNode(withName: "Interactable_GemDias") as? SKTileMapNode else {return}
        
        var dais = [Dais]()
        var i = 0
        for row in 0..<gemMap.numberOfRows
        {
            for column in 0..<gemMap.numberOfColumns
            {
                guard tile(in: gemMap, at: (column, row)) != nil else {continue}
                dais.append( Dais(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "switch_floor_on"), d: gameScene!.doorArray![3]))
                gameScene!.addEntity(entity: dais[i])
                gemMap.removeFromParent()
                i += 1
            }
        }
        linkDaii(d : dais)
    }
    
    func linkDaii(d : [Dais])
    {
        var i = -1
        for _ in d
        {
            i += 1
        }
        for object in d
        {
            for j in 0 ... i
            {
                if object != d[j]
                {
                    object.oDais.append(d[j])
                }
            }
        }
    }
    
    func createEnemies()
    {
        guard let enemyMap = gameScene!.childNode(withName: "Interactable_Enemy") as? SKTileMapNode else {return}
        for row in 0..<enemyMap.numberOfRows
        {
            for column in 0..<enemyMap.numberOfColumns
            {
                guard tile(in: enemyMap, at: (column, row)) != nil else {continue}
                gameScene!.addEntity(entity: LesserSkeleton(x: tempX!, y: tempY!, z: 9, s: SKSpriteNode(imageNamed: "Skeleton-Idle_01")))
                enemyMap.removeFromParent()
            }
        }
    }
    
    func createAlcoves()
    {
        //let tempItemp = Item(s: SKSpriteNode(fileNamed: "gem_01c")
        guard let alcMap = gameScene!.childNode(withName: "Collectable_Alcove") as? SKTileMapNode else {return}
        for row in 0..<alcMap.numberOfRows
        {
            for column in 0..<alcMap.numberOfColumns
            {
                guard tile(in: alcMap, at: (column, row)) != nil else {continue}
                gameScene!.addEntity(entity: Collectable(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "window_3_02"), i: Gem(s: ISNode(imageNamed: "gem_01c"))))
                    
                alcMap.removeFromParent()
            }
        }
        
    }
    
    func createWallCollisions()
    {
        guard let colMap1 = gameScene!.childNode(withName: "TopWalls") as? SKTileMapNode else {return}
        for row in 0..<colMap1.numberOfRows
        {
            for column in 0..<colMap1.numberOfColumns
            {
                guard tile(in: colMap1, at: (column, row)) != nil else {continue}
                gameScene!.addEntity(entity: World(bottom: tempY! - 8, left: tempX! - 8, top: tempY! + 8, right: tempX! + 8))
            }
        }
        guard let colMap2 = gameScene!.childNode(withName: "BotCollisions") as? SKTileMapNode else {return}
        for row in 0..<colMap2.numberOfRows
        {
            for column in 0..<colMap2.numberOfColumns
            {
                guard tile(in: colMap2, at: (column, row)) != nil else {continue}
                gameScene!.addEntity(entity: World(bottom: tempY! - 8, left: tempX! - 8, top: tempY! + 8, right: tempX! + 8))
                colMap2.removeFromParent()
            }
        }
    }
    
    func createChests()
    {
        guard let chestMap = gameScene!.childNode(withName: "Interactable_Chest") as? SKTileMapNode else {return}
        for row in 0..<chestMap.numberOfRows
        {
            for column in 0..<chestMap.numberOfColumns
            {
                guard tile(in: chestMap, at: (column, row)) != nil else {continue}
                let tempChest = Chest(x: tempX!, y: tempY!, z: 5, s: SKSpriteNode(imageNamed: "chest_closed"), i: Rock())
                tempChest.gameScene = gameScene
                gameScene!.addEntity(entity: tempChest)
                chestMap.removeFromParent()
            }
        }
    }
}
