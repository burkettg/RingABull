//
//  Room.swift
//  RingABull
//
//  Created by Greg Burkett on 10/19/24.
//

import SwiftUI
import SceneKit
import UIKit

struct Room {
    var level: Int
    var rr = RopeAndRing(level: 1)
    // Custom initializer the level parameter
    init(level: Int) {
        self.level = level
        rr.level = level
    }
    
    func addRoom(to scene: SCNScene, coordinator: PhysicsWorldCoordinator) -> SCNNode? {
        let woodMaterial = SCNMaterial()
        woodMaterial.diffuse.contents = UIImage(named: "wood_texture")  // Use a wood texture
        let beamThickness: CGFloat = 0.3
        
        let floor = SCNFloor()
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = SCNVector3(0, 0, 0)  // Position the floor at ground level (y = 0)
        floorNode.physicsBody = SCNPhysicsBody.static()  // Static physics body for the floor
        //floor.materials = [woodMaterial]
        floor.firstMaterial?.diffuse.contents =
                                                switch level {
                                                case 1: UIImage(named: "dirtFloor")
                                                case 2: UIImage(named: "tilesAqua")
                                                case 3: UIImage(named: "planksDark")
                                                case 4: UIImage(named: "woodWorn")
                                                case 5: UIColor.orange
                                                default: UIColor.brown
                                                }
        scene.rootNode.addChildNode(floorNode)

        // Add back wall with target
        let wallWidth: CGFloat = 10.0
        let wallHeight: CGFloat = 8.0
        let wallDepth: CGFloat = 0.2  // Thickness of the walls

        let backWall = SCNBox(width: wallWidth, height: wallHeight, length: wallDepth, chamferRadius: 0)
        backWall.firstMaterial?.diffuse.contents =
                                                switch level {
                                                case 1: UIImage(named: "tilesAqua")
                                                case 2: UIImage(named: "metalRusty")
                                                case 3: UIImage(named: "woodWeathered")
                                                case 4: UIImage(named: "bricksWorn")
                                                case 5: UIImage(named: "planksDark")
                                                default: UIImage(named: "tilesAqua")
                                                }
        let backWallNode = SCNNode(geometry: backWall)
        backWallNode.position = SCNVector3(0, wallHeight / 2, -wallWidth / 2)  // Position back wall
        backWallNode.physicsBody = SCNPhysicsBody.static()
        scene.rootNode.addChildNode(backWallNode)

        // Add a target to the back wall (a simple red sphere)
        let target = SCNSphere(radius: 0.3)
        let targetMaterial = SCNMaterial()
        targetMaterial.diffuse.contents =
                                            switch level {
                                            case 1: UIColor.brown
                                            case 2: UIColor.blue
                                            case 3: UIColor.green
                                            case 4: UIColor.red
                                            case 5: UIColor.orange
                                            default: UIColor.brown
                                            }
        target.materials = [targetMaterial]
        let targetNode = SCNNode(geometry: target)
        targetNode.position = SCNVector3(0, wallHeight / 2, -wallWidth / 2 + 0.2)  // Slightly in front of wall
        targetNode.physicsBody = SCNPhysicsBody.static()  // Target is static
        scene.rootNode.addChildNode(targetNode)
        
        
        //  Some hook shit..
        
        // Create the hook base (vertical cylinder)
        let hookBase = SCNCylinder(radius: 0.1, height: 1.0) // Thin vertical cylinder
        let hookMaterial = SCNMaterial()
        hookMaterial.diffuse.contents = UIColor.orange // Hook color
        hookBase.materials = [hookMaterial]

        let hookBaseNode = SCNNode(geometry: hookBase)
        hookBaseNode.position = SCNVector3(0, wallHeight / 2, -wallWidth / 2 + 1.2) // Centered on the wall
        hookBaseNode.physicsBody = SCNPhysicsBody.static() // Static physics body
        hookBaseNode.physicsBody?.categoryBitMask = CollisionCategory.hook
        hookBaseNode.physicsBody?.contactTestBitMask = CollisionCategory.ring
       scene.rootNode.addChildNode(hookBaseNode)

        // Add the angled part of the hook (cylinder angled upward)
        let hookPart = SCNCylinder(radius: 0.10, height: 1.5) // Thin cylinder for the angled part
        let hookPartNode = SCNNode(geometry: hookPart)
        hookPartNode.geometry?.materials = [hookMaterial]
        hookPartNode.position = SCNVector3(0, 0.5, 0) // Position relative to the hook base
        hookPartNode.eulerAngles = SCNVector3(-Float.pi / 4, 0, 0) // Angle the hook part upward
        hookBaseNode.addChildNode(hookPartNode) // Attach to the base

        // Add the hook tip (optional rounded tip using a torus)
        let hookTip = SCNTorus(ringRadius: 0.15, pipeRadius: 0.03) // Torus for the curved tip
        let hookTipNode = SCNNode(geometry: hookTip)
        hookTipNode.geometry?.materials = [hookMaterial]
        hookTipNode.position = SCNVector3(0, 0.8, 0.2) // Adjust position to align with the upward stick
        hookTipNode.eulerAngles = SCNVector3(-Float.pi / 2, 0, 0) // Rotate to align correctly
        hookBaseNode.addChildNode(hookTipNode) // Attach to the base


        

        // Add left and right walls (similarly to the back wall)
        let leftWall = SCNBox(width: wallDepth, height: wallHeight, length: wallWidth, chamferRadius: 0)
        leftWall.firstMaterial?.diffuse.contents =
                                            switch level {
                                            case 1: UIImage(named: "tilesAqua")
                                            case 2: UIImage(named: "metalRusty")
                                            case 3: UIImage(named: "woodWeathered")
                                            case 4: UIImage(named: "bricksWorn")
                                            case 5: UIImage(named: "planksDark")
                                            default: UIImage(named: "tilesAqua")
                                            }
        let leftWallNode = SCNNode(geometry: leftWall)
        leftWallNode.position = SCNVector3(-wallWidth / 2, wallHeight / 2, 0)
        leftWallNode.physicsBody = SCNPhysicsBody.static()
        scene.rootNode.addChildNode(leftWallNode)

        let rightWall = SCNBox(width: wallDepth, height: wallHeight, length: wallWidth, chamferRadius: 0)
        rightWall.firstMaterial?.diffuse.contents =
                                            switch level {
                                            case 1: UIImage(named: "tilesAqua")
                                            case 2: UIImage(named: "metalRusty")
                                            case 3: UIImage(named: "woodWeathered")
                                            case 4: UIImage(named: "bricksWorn")
                                            case 5: UIImage(named: "planksDark")
                                            default: UIImage(named: "tilesAqua")
                                            }
        let rightWallNode = SCNNode(geometry: rightWall)
        rightWallNode.position = SCNVector3(wallWidth / 2, wallHeight / 2, 0)
        rightWallNode.physicsBody = SCNPhysicsBody.static()
        scene.rootNode.addChildNode(rightWallNode)

        // Add ceiling (same as wall, but thin)
        let ceiling = SCNBox(width: wallWidth, height: wallDepth, length: wallWidth, chamferRadius: 0)
        ceiling.materials = [woodMaterial]
        let ceilingNode = SCNNode(geometry: ceiling)
        ceilingNode.position = SCNVector3(0, wallHeight, 0)
        ceilingNode.physicsBody = SCNPhysicsBody.static()
        scene.rootNode.addChildNode(ceilingNode)

        // Add the beam across the ceiling where the rope will hang
        let beamLength: CGFloat = 8.0
        
        let beam = SCNBox(width: beamLength, height: beamThickness, length: 0.3, chamferRadius: 0)
        let beamNode = SCNNode(geometry: beam)
        beamNode.position = SCNVector3(0, wallHeight - beamThickness / 2, -wallWidth / 2 + 4.0)  // Beam's position
        //SCNVector3(0, wallHeight / 2, -wallWidth / 2 + 0.2)
        beamNode.physicsBody = SCNPhysicsBody.static()  // Beam is static
        beamNode.name = "beam"  // Name the beam so we can reference it later
            
        // Color the beam red for visibility
        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents =
                                        switch level {
                                        case 1: UIColor.yellow
                                        case 2: UIColor.brown
                                        case 3: UIColor.blue
                                        case 4: UIColor.green
                                        case 5: UIColor.darkGray
                                        default: UIColor.orange
                                        }
        beam.materials = [redMaterial]
        
        scene.rootNode.addChildNode(beamNode)

        // Add a light to the scene for better visibility
        let light = SCNLight()
        light.type = .omni
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(0, wallHeight, 10)  // Position the light above and in front
        scene.rootNode.addChildNode(lightNode)

        // Add a camera to ensure the scene is visible
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, wallHeight / 2, 10)  // Move the camera to see the entire scene
        scene.rootNode.addChildNode(cameraNode)
        
        // Set the background color for better contrast
        scene.background.contents = UIColor.gray  // Gray background to contrast with the green rope segment
            
        // Hang the rope from the beam
        let ringNode = rr.addRopeAndRing(to: scene, hangingFrom: beamNode.position, coordinator: coordinator)
        
        return ringNode
        
    }
    
}
