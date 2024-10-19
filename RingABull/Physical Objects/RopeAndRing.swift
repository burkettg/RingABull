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
struct RopeAndRing {

    func addRopeAndRing_Level02(to scene: SCNScene, hangingFrom anchorPosition: SCNVector3) {
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
            
            // Give the rope segment a green color for visibility
            let greenMaterial = SCNMaterial()
            greenMaterial.diffuse.contents = UIColor.green
            ropeSegment.materials = [greenMaterial]

            // Position each segment directly below the previous one
            let yPos = anchorPosition.y - (Float(i + 1) * Float(ropeSegmentHeight))
            ropeSegmentNode.position = SCNVector3(anchorPosition.x, yPos, anchorPosition.z)
            
            // Assign a dynamic physics body to the rope segment
            ropeSegmentNode.physicsBody = SCNPhysicsBody.dynamic()
            ropeSegmentNode.physicsBody?.mass = 0.05  // Light mass for the segments
            
            // Add the rope segment to the scene
            scene.rootNode.addChildNode(ropeSegmentNode)
            
            // Create a ball-socket joint between the current segment and the previous one
            // Using local positions: Top of previous node (+height/2) connects to bottom of current node (-height/2)
            let joint = SCNPhysicsBallSocketJoint(bodyA: previousNode.physicsBody!,
                                                  anchorA: SCNVector3(0, -Float(ropeSegmentHeight) / 2, 0),  // Bottom of previous segment
                                                  bodyB: ropeSegmentNode.physicsBody!,
                                                  anchorB: SCNVector3(0, Float(ropeSegmentHeight) / 2, 0))   // Top of current segment
            scene.physicsWorld.addBehavior(joint)
            
            // Move to the next segment
            previousNode = ropeSegmentNode
        }
        
        // Now create the metal ring at the bottom of the rope
        let ring = SCNTorus(ringRadius: 0.5, pipeRadius: 0.1)
        let ringNode = SCNNode(geometry: ring)

        // Apply a 90-degree (π/2 radians) rotation to the ring so it hangs vertically
        ringNode.eulerAngles.x = Float.pi / 2  // Rotate the ring around the X-axis

        // Position the ring at the bottom of the last rope segment
        let lastYPosition = anchorPosition.y - (Float(ropeSegmentCount + 1) * Float(ropeSegmentHeight))
        ringNode.position = SCNVector3(anchorPosition.x, lastYPosition, anchorPosition.z)

        // Add a dynamic physics body to the ring
        ringNode.physicsBody = SCNPhysicsBody.dynamic()
        ringNode.physicsBody?.mass = 1.0  // Heavier mass for the metal ring

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
        
        
    }// End Adding rope and ring.
    
}

