//
//  PhysicsContactHandler.swift
//  RingABull
//
//  Created by Greg Burkett on 12/18/24.
//

import SceneKit

// Define Collision Categories
struct CollisionCategory {
    static let ring = 1 << 0 // 0001
    static let hook = 1 << 1 // 0010
}

// Physics Contact Handler
class PhysicsContactHandler: NSObject, SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB

        if (nodeA.physicsBody?.categoryBitMask == CollisionCategory.ring &&
            nodeB.physicsBody?.categoryBitMask == CollisionCategory.hook) ||
           (nodeA.physicsBody?.categoryBitMask == CollisionCategory.hook &&
            nodeB.physicsBody?.categoryBitMask == CollisionCategory.ring) {

            // Change the ring's color
            let ringNode = (nodeA.physicsBody?.categoryBitMask == CollisionCategory.ring) ? nodeA : nodeB
            print("We got a collision...........")
            print("Collision detected between \(contact.nodeA.name ?? "unknown") and \(contact.nodeB.name ?? "unknown")")
           
            changeRingColor(ringNode: ringNode)
        }
    }

    private func changeRingColor(ringNode: SCNNode) {
        if let ringGeometry = ringNode.geometry {
            let newMaterial = SCNMaterial()
            newMaterial.diffuse.contents = UIColor.cyan
            ringGeometry.materials = [newMaterial]
        }
    }
}

