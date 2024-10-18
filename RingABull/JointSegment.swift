//
//  JointSegment.swift
//  RingABull
//
//  Created by Greg Burkett on 10/18/24.
//

import SwiftUI
import SceneKit
import UIKit

// Struct for Ball-Socket Joint
struct Joint {
    var bodyA: SCNPhysicsBody
    var bodyB: SCNPhysicsBody
    var anchorA: SCNVector3
    var anchorB: SCNVector3

    func createJoint(in scene: SCNScene) {
        // Create and add the ball-socket joint to the physics world
        let joint = SCNPhysicsBallSocketJoint(bodyA: bodyA, anchorA: anchorA, bodyB: bodyB, anchorB: anchorB)
        scene.physicsWorld.addBehavior(joint)
        print("Joint added between \(bodyA) and \(bodyB)")
    }
}

