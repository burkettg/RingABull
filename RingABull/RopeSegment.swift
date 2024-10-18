//
//  RopeSegment.swift
//  RingABull
//
//  Created by Greg Burkett on 10/18/24.
//

import SwiftUI
import SceneKit
import UIKit

// Struct for Rope Segment
struct RopeSegment {
    var position: SCNVector3
    var height: CGFloat = 1.5
    var radius: CGFloat = 0.1
    var color: UIColor = .green

    func createSegment() -> SCNNode {
        // Create the rope segment geometry (cylinder)
        let ropeSegment = SCNCylinder(radius: radius, height: height)
        let ropeSegmentNode = SCNNode(geometry: ropeSegment)

        // Set the rope segment's color
        let material = SCNMaterial()
        material.diffuse.contents = color
        ropeSegment.materials = [material]

        // Position the segment
        ropeSegmentNode.position = position

        // Add physics body to the rope segment with rotation locked
        let ropePhysicsBody = SCNPhysicsBody.dynamic()
        ropePhysicsBody.mass = 0.01  // Lightweight to respond gently to gravity
        ropePhysicsBody.isAffectedByGravity = true
        ropePhysicsBody.allowsResting = true  // Allow rope to rest after movement
        ropePhysicsBody.angularDamping = 0.9  // Slow down spinning
        ropePhysicsBody.damping = 0.5  // Slow down linear motion
        //ropePhysicsBody.angularVelocityFactor = SCNVector3(0, 0, 0)  // Lock rotation temporarily

        ropeSegmentNode.physicsBody = ropePhysicsBody

        return ropeSegmentNode
    }
}

