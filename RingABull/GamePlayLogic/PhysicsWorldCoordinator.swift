//
//  PhysicsWorldCoordinator.swift
//  RingABull
//
//  Created by Greg Burkett on 10/20/24.
//

import SceneKit
import Combine

class PhysicsWorldCoordinator: ObservableObject {
    @Published var ringNode: SCNNode?  // Store the ring node
    @Published var ropeSegments: [SCNNode] = []  // Store the rope segments
    @Published var joints: [SCNPhysicsBehavior] = []  // Store joints in the coordinator
    private var scene: SCNScene?  // Store the scene

    // Set the ring node
    func setRingNode(_ node: SCNNode) {
        self.ringNode = node
    }

    // Set the scene
    func setScene(_ scene: SCNScene) {
        self.scene = scene
    }

    // Set the rope segments
    func setRopeSegments(_ segments: [SCNNode]) {
        self.ropeSegments = segments
    }

    // Remove a joint from the physics world
    func removeJoint(_ joint: SCNPhysicsBehavior) {
        if let scene = self.scene {
            scene.physicsWorld.removeBehavior(joint)
        } else {
            print("Error: Could not find scene to remove joint.")
        }
    }

    // Re-add a joint to the physics world
    func addJoint(_ joint: SCNPhysicsBehavior) {
        if let scene = self.scene {
            scene.physicsWorld.addBehavior(joint)
        } else {
            print("Error: Could not find scene to add joint.")
        }
    }
}





