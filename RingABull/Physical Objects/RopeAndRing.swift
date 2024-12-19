//
//  RopeAndRing.swift
//  RingABull
//
//  Created by Greg Burkett on 10/18/24.
//

import SwiftUI
import SceneKit
import UIKit

// Struct for Rope Segment
class RopeAndRing {
    var level: Int
    var ropeSegments: [SCNNode] = []  // Store rope segments
    // Custom initializer the level parameter
    init(level: Int) {
        self.level = level
    }
    
    func addRopeAndRing(to scene: SCNScene, hangingFrom anchorPosition: SCNVector3, coordinator: PhysicsWorldCoordinator) -> SCNNode {
        // Create the static node for the anchor (beam)
        let anchorNode = SCNNode()
        anchorNode.position = anchorPosition
        anchorNode.physicsBody = SCNPhysicsBody.static()  // Static physics body for the beam
        scene.rootNode.addChildNode(anchorNode)
        
        // Define rope properties
        let ropeSegmentCount = 10
        let ropeSegmentHeight: CGFloat = 0.40  // Height of each segment
        let ropeRadius: CGFloat = 0.10  // Thin twine-style rope
            
        // Track the previous node (starting with the anchor node)
        var previousNode: SCNNode = anchorNode
        
        for i in 0..<ropeSegmentCount {
            // Create a cylinder for each rope segment
            let ropeSegment = SCNCylinder(radius: ropeRadius, height: ropeSegmentHeight)
            let ropeSegmentNode = SCNNode(geometry: ropeSegment)
            
            // Give the rope segment a green color for visibility
            let ropeMaterial = SCNMaterial()
            ropeMaterial.diffuse.contents =
                                            switch level {
                                            case 1: UIColor.green
                                            case 2: UIColor.red
                                            case 3: UIColor.blue
                                            case 4: UIColor.gray
                                            case 5: UIColor.yellow
                                            default: UIColor.green
                                            }
            ropeSegment.materials = [ropeMaterial]

            // Position each segment directly below the previous one
            let yPos = anchorPosition.y - (Float(i + 1) * Float(ropeSegmentHeight))
            ropeSegmentNode.position = SCNVector3(anchorPosition.x, yPos, anchorPosition.z)
            
            // Assign a dynamic physics body to the rope segment
            ropeSegmentNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            ropeSegmentNode.physicsBody?.isAffectedByGravity = true  // Disable gravity initially
            
            switch i {
            case 1: ropeSegmentNode.physicsBody?.mass = 15.0  // Light mass for the segments
            case 2: ropeSegmentNode.physicsBody?.mass = 25.0  // Light mass for the segments
            case 3: ropeSegmentNode.physicsBody?.mass = 35.0  // Light mass for the segments
            case 4: ropeSegmentNode.physicsBody?.mass = 35.0  // Light mass for the segments
            case 5: ropeSegmentNode.physicsBody?.mass = 35.0  // Light mass for the segments
            case 6: ropeSegmentNode.physicsBody?.mass = 45.0  // Light mass for the segments
            case 7: ropeSegmentNode.physicsBody?.mass = 45.0  // Light mass for the segments
            case 8: ropeSegmentNode.physicsBody?.mass = 45.0  // Light mass for the segments
            case 9: ropeSegmentNode.physicsBody?.mass = 55.0  // Light mass for the segments
            case 10: ropeSegmentNode.physicsBody?.mass = 55.0  // Light mass for the segments
            default: ropeSegmentNode.physicsBody?.mass = 65.0  // Light mass for the segments
            }
            //ropeSegmentNode.physicsBody?.mass = 35.0  // Light mass for the segments
            
            
            ropeSegmentNode.physicsBody?.restitution = 0.01 // Remove bounciness
            // Add the rope segment to the scene
            scene.rootNode.addChildNode(ropeSegmentNode)
            
            // Create a ball-socket joint between the current segment and the previous one
            // Using local positions: Top of previous node (+height/2) connects to bottom of current node (-height/2)
        /*    let joint = SCNPhysicsBallSocketJoint(bodyA: previousNode.physicsBody!,
                                                  anchorA: SCNVector3(0, -Float(ropeSegmentHeight) / 2, 0),  // Bottom of previous segment
                                                  bodyB: ropeSegmentNode.physicsBody!,
                                                  anchorB: SCNVector3(0, Float(ropeSegmentHeight) / 2, 0))   // Top of current segment
            
            scene.physicsWorld.addBehavior(joint)
         */
            
            let sliderJoint = SCNPhysicsSliderJoint(
                        bodyA: previousNode.physicsBody!,
                        axisA: SCNVector3(0, 1, 0), // Vertical axis for movement
                        anchorA: SCNVector3(0, -Float(ropeSegmentHeight) / 2, 0),  // Bottom of previous segment
                        bodyB: ropeSegmentNode.physicsBody!,
                        axisB: SCNVector3(0, 1, 0),  // Vertical axis for movement
                        anchorB: SCNVector3(0, Float(ropeSegmentHeight) / 2, 0)   // Top of current segment
                    )
                    
                    sliderJoint.minimumLinearLimit = 0 // Prevent segments from moving closer
                    sliderJoint.maximumLinearLimit = 0 // Prevent segments from stretching apart
                    
                    scene.physicsWorld.addBehavior(sliderJoint)
            
            
            // Move to the next segment
            previousNode = ropeSegmentNode
            
            // Add to the list of rope segments
            ropeSegments.append(ropeSegmentNode)
            
        }
        
        // After creating the rope segments, assign them to the coordinator
        coordinator.setRopeSegments(ropeSegments)
        
        // Now create the metal ring at the bottom of the rope
        let ring = SCNTorus(ringRadius: 0.5, pipeRadius: 0.1)
        let ringNode = SCNNode(geometry: SCNTorus(ringRadius: 0.5, pipeRadius: 0.1))
        
        let ringMaterial = SCNMaterial()
        ringMaterial.diffuse.contents =
                switch level {
                case 1: UIColor.red
                case 2: UIColor.purple
                case 3: UIColor.yellow
                case 4: UIColor.green
                case 5: UIColor.red
                default: UIColor.blue
                }
        ring.materials = [ringMaterial]

        // Add a dynamic physics body to the ring
        ringNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)  // Add dynamic physics body
        
        // Apply a 90-degree (π/2 radians) rotation to the ring so it hangs vertically
        ringNode.eulerAngles.x = Float.pi / 2  // Rotate the ring around the X-axis
        // Position the ring at the bottom of the last rope segment
        let lastYPosition = anchorPosition.y - (Float(ropeSegmentCount + 1) * Float(ropeSegmentHeight))
        ringNode.position = SCNVector3(anchorPosition.x, lastYPosition, anchorPosition.z)
        ringNode.physicsBody?.mass = 65.0  // Heavier mass for the metal ring
        ringNode.physicsBody?.restitution = 0.01 // Remove bounciness
        ringNode.physicsBody?.isAffectedByGravity = true
        ringNode.physicsBody?.allowsResting = true
        // assign collision categories to detect contact
        ringNode.physicsBody?.categoryBitMask = CollisionCategory.ring
        ringNode.physicsBody?.contactTestBitMask = CollisionCategory.hook
        
        
        ringNode.name = "ringNode"
        // Corrected attachment point: Top of the ring's outer edge
        let ringTopAttachmentPoint = SCNVector3(0, 0, Float(ring.ringRadius + ring.pipeRadius))

        // Attach the ring to the last segment with a ball-socket joint
        let ringJoint = SCNPhysicsBallSocketJoint(bodyA: previousNode.physicsBody!,  // Physics body of the last rope segment
                                                  anchorA: SCNVector3(0, -Float(ropeSegmentHeight) / 2, 0),  // Bottom of last rope segment
                                                  bodyB: ringNode.physicsBody!,  // Physics body of the ring
                                                  anchorB: ringTopAttachmentPoint)  // Top outer edge of the ring
        scene.physicsWorld.addBehavior(ringJoint)
        // Add the ring to the scene
        scene.rootNode.addChildNode(ringNode)
        
        return ringNode
        
    }// End Adding rope and ring.
    
}

