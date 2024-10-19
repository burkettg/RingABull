//
//  PhysicsWorldView_Level01.swift
//  RingABull
//
//  Created by Greg Burkett on 10/18/24.
//

import SwiftUI
import SceneKit
import UIKit

struct PhysicsWorldView_Level01: UIViewRepresentable {
    let rr = RopeAndRing()
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = createScene()
        
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = UIColor.blue
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
    
    func createScene() -> SCNScene {
        let scene = SCNScene()
        
        // Ensure gravity is applied to the scene
        scene.physicsWorld.gravity = SCNVector3(0, -2.8, 0)  // Standard Earth gravity
        
        // Add the room (walls, floor, ceiling)
        addRoom(to: scene)
        
        
        
        return scene
    }
    
    
    
    func addRoom(to scene: SCNScene) {
        let woodMaterial = SCNMaterial()
        woodMaterial.diffuse.contents = UIImage(named: "wood_texture")  // Use a wood texture
        let beamThickness: CGFloat = 0.3
        
        let floor = SCNFloor()
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = SCNVector3(0, 0, 0)  // Position the floor at ground level (y = 0)
        floorNode.physicsBody = SCNPhysicsBody.static()  // Static physics body for the floor
        floor.firstMaterial?.diffuse.contents = UIColor.brown  // Brown color for the floor
        scene.rootNode.addChildNode(floorNode)

        print("Added a static floor at position \(floorNode.position).")

        // Add back wall with target
        let wallWidth: CGFloat = 10.0
        let wallHeight: CGFloat = 8.0
        let wallDepth: CGFloat = 0.2  // Thickness of the walls

        let backWall = SCNBox(width: wallWidth, height: wallHeight, length: wallDepth, chamferRadius: 0)
        backWall.materials = [woodMaterial]
        let backWallNode = SCNNode(geometry: backWall)
        backWallNode.position = SCNVector3(0, wallHeight / 2, -wallWidth / 2)  // Position back wall
        backWallNode.physicsBody = SCNPhysicsBody.static()
        scene.rootNode.addChildNode(backWallNode)

        // Add a target to the back wall (a simple red sphere)
        let target = SCNSphere(radius: 0.3)
        let targetMaterial = SCNMaterial()
        targetMaterial.diffuse.contents = UIColor.red
        target.materials = [targetMaterial]
        let targetNode = SCNNode(geometry: target)
        targetNode.position = SCNVector3(0, wallHeight / 2, -wallWidth / 2 + 0.2)  // Slightly in front of wall
        targetNode.physicsBody = SCNPhysicsBody.static()  // Target is static
        scene.rootNode.addChildNode(targetNode)

        // Add left and right walls (similarly to the back wall)
        let leftWall = SCNBox(width: wallDepth, height: wallHeight, length: wallWidth, chamferRadius: 0)
        leftWall.materials = [woodMaterial]
        let leftWallNode = SCNNode(geometry: leftWall)
        leftWallNode.position = SCNVector3(-wallWidth / 2, wallHeight / 2, 0)
        leftWallNode.physicsBody = SCNPhysicsBody.static()
        scene.rootNode.addChildNode(leftWallNode)

        let rightWall = SCNBox(width: wallDepth, height: wallHeight, length: wallWidth, chamferRadius: 0)
        rightWall.materials = [woodMaterial]
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
            beamNode.position = SCNVector3(0, wallHeight - beamThickness / 2, 0)  // Beam's position
            beamNode.physicsBody = SCNPhysicsBody.static()  // Beam is static
            beamNode.name = "beam"  // Name the beam so we can reference it later
            
        // Color the beam red for visibility
            let redMaterial = SCNMaterial()
            redMaterial.diffuse.contents = UIColor.red
            beam.materials = [redMaterial]
            
            scene.rootNode.addChildNode(beamNode)

        
        // Hang the rope from the beam
            rr.addRopeAndRing_Level02(to: scene, hangingFrom: beamNode.position)
        
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
            cameraNode.position = SCNVector3(0, wallHeight / 2, 15)  // Move the camera to see the entire scene
            scene.rootNode.addChildNode(cameraNode)
        
        // Set the background color for better contrast
            scene.background.contents = UIColor.gray  // Gray background to contrast with the green rope segment

            
        print("Gravity set to \(scene.physicsWorld.gravity)")
        
    }
    


} // End struct



