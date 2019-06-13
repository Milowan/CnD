//
//  GameViewController.swift
//  CnD_v1
//
//  Created by Michael Sweeny on 2019-06-02.
//  Copyright © 2019 Michael Sweeny. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let scene = GameScene.level(levelNum: 1)
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }
    override var prefersStatusBarHidden: Bool
    {
            return true
    }
}
