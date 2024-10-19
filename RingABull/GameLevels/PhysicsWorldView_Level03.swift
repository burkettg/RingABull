//
//  PhysicsWorldView_Level03.swift
//  RingABull
//
//  Created by Greg Burkett on 10/19/24.
//

import SwiftUI
import SceneKit
import UIKit

struct PhysicsWorldView_Level03: UIViewRepresentable {
    
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
        
        // Add the room (walls, floor, ceiling)
        addRoom(to: scene)
        
        return scene
    }
    


    func addFirstSegment(to scene: SCNScene, hangingFrom anchorPosition: SCNVector3) {
        // Create the first rope segment (cylinder)
        let ropeSegmentHeight: CGFloat = 1.5  // Height of the rope segment
        let ropeRadius: CGFloat = 0.05  // Radius of the rope segment
        let ropeSegment = SCNCylinder(radius: ropeRadius, height: ropeSegmentHeight)
        let ropeSegmentNode = SCNNode(geometry: ropeSegment)

        // Give the rope segment a green color for visibility
        let greenMaterial = SCNMaterial()
        greenMaterial.diffuse.contents = UIColor.green
        ropeSegment.materials = [greenMaterial]

        // Position the rope segment directly below the beam (avoiding any overlap)
        let yPos = anchorPosition.y - Float(ropeSegmentHeight)  // Clearly below the beam
        ropeSegmentNode.position = SCNVector3(anchorPosition.x, yPos, anchorPosition.z)

        // Add a dynamic physics body to the rope segment to allow it to fall due to gravity
        ropeSegmentNode.physicsBody = SCNPhysicsBody.dynamic()
        ropeSegmentNode.physicsBody?.mass = 0.05  // Lightweight
        ropeSegmentNode.physicsBody?.isAffectedByGravity = true  // Ensure gravity affects it

        // Log the rope segment details
        print("Added green rope segment at position: \(ropeSegmentNode.position) with physics body.")

        // Add the rope segment to the scene
        scene.rootNode.addChildNode(ropeSegmentNode)

        // No joint for now — we just want to observe how the segment behaves with gravity
    }




    
    func addRoom(to scene: SCNScene) {
        let woodMaterial = SCNMaterial()
        woodMaterial.diffuse.contents = UIImage(named: "wood_texture")  // Use a wood texture
        let beamThickness: CGFloat = 0.3
        
        let floor = SCNFloor()
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = SCNVector3(0, 0, 0)  // Position the floor at ground level (y = 0)
        floorNode.physicsBody = SCNPhysicsBody.static()  // Static physics body for the floor
        floor.firstMaterial?.diffuse.contents = UIColor.blue  // Brown color for the floor
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
        targetMaterial.diffuse.contents = UIColor.purple
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

        // Add the first rope segment attached to the beam's center
            addFirstSegment(to: scene, hangingFrom: beamNode.position)
        
            // Now add the first rope segment attached to the beam's center
        //addRopeAndJoint(to: scene, hangingFrom: beamNode.position)
        
        // Hang the rope from the beam
        //addRopeAndRing(to: scene, hangingFrom: beamNode.position)  // Call addRopeAndRing after room setup
        
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

            // Ensure gravity is applied to the scene
            scene.physicsWorld.gravity = SCNVector3(0, -2.8, 0)  // Standard Earth gravity
        print("Gravity set to \(scene.physicsWorld.gravity)")
        
    }
    

    

    




    func addRopeAndRing(to scene: SCNScene, hangingFrom anchorPosition: SCNVector3) {
        // Create the static node for the anchor (beam)
        let anchorNode = SCNNode()
        anchorNode.position = anchorPosition
        anchorNode.physicsBody = SCNPhysicsBody.static()  // Static physics body for the beam
        scene.rootNode.addChildNode(anchorNode)
        
        // Define rope properties
        let ropeSegmentCount = 12
        let ropeSegmentHeight: CGFloat = 0.4  // Height of each segment
        let ropeRadius: CGFloat = 0.05  // Thin twine-style rope
        
        // Track the previous node (starting with the anchor node)
        var previousNode: SCNNode = anchorNode
        
        for i in 0..<ropeSegmentCount {
            // Create a cylinder for each rope segment
            let ropeSegment = SCNCylinder(radius: ropeRadius, height: ropeSegmentHeight)
            let ropeSegmentNode = SCNNode(geometry: ropeSegment)
            
            // Position each segment directly below the previous one
            let yPos = anchorPosition.y - (Float(i + 1) * Float(ropeSegmentHeight))  // Stacking down from the beam
            ropeSegmentNode.position = SCNVector3(anchorPosition.x, yPos, anchorPosition.z)
            
            // Assign a dynamic physics body to the rope segment
            ropeSegmentNode.physicsBody = SCNPhysicsBody.dynamic()
            ropeSegmentNode.physicsBody?.mass = 0.05  // Light mass for the segments
            
            // Add the rope segment to the scene
            scene.rootNode.addChildNode(ropeSegmentNode)
            
            // Create a ball-socket joint between the current segment and the previous one
            let joint = SCNPhysicsBallSocketJoint(bodyA: previousNode.physicsBody!,
                                                  anchorA: previousNode.position,
                                                  bodyB: ropeSegmentNode.physicsBody!,
                                                  anchorB: ropeSegmentNode.position)
            scene.physicsWorld.addBehavior(joint)
            
            // Move to the next segment
            previousNode = ropeSegmentNode
        }
        
        // Now create the metal ring at the bottom of the rope
        let ring = SCNTorus(ringRadius: 0.5, pipeRadius: 0.1)
        let ringNode = SCNNode(geometry: ring)
        
        // Position the ring at the bottom of the last rope segment
        let lastYPosition = anchorPosition.y - (Float(ropeSegmentCount + 1) * Float(ropeSegmentHeight))
        ringNode.position = SCNVector3(anchorPosition.x, lastYPosition, anchorPosition.z)
        
        // Add a dynamic physics body to the ring
        ringNode.physicsBody = SCNPhysicsBody.dynamic()
        ringNode.physicsBody?.mass = 1.0  // Heavier mass for the metal ring
        
        // Attach the ring to the last segment with a ball-socket joint
        let ringJoint = SCNPhysicsBallSocketJoint(bodyA: previousNode.physicsBody!,
                                                  anchorA: previousNode.position,
                                                  bodyB: ringNode.physicsBody!,
                                                  anchorB: ringNode.position)
        scene.physicsWorld.addBehavior(ringJoint)
        
        // Add the ring to the scene
        scene.rootNode.addChildNode(ringNode)
        
    } // End Adding rope and ring.

} // End struct



