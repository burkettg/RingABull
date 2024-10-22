//
//  PhysicsWorldView_Level02.swift
//  RingABull
//
//  Created by Greg Burkett on 10/18/24.
//

import SwiftUI
import SceneKit
import UIKit


struct PhysicsWorldView_Level02: UIViewRepresentable {
    @Binding var xPosition: Float
    @Binding var zPosition: Float
    
    let room = Room(level: 2)
    var coordinator: PhysicsWorldCoordinator  // Accept coordinator from the parent view

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = createScene(context: context)
        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = true

        // Debug print to ensure the scene is not nil
        if sceneView.scene == nil {
            print("Error: SceneView's scene is nil!")
        } else {
            print("SceneView's scene is initialized.")
        }
        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // Update the ring's position based on the slider values
        if let ring = coordinator.ringNode {
            // Disable physics while the ring is being moved manually
            if let physicsBody = ring.physicsBody {
                physicsBody.isAffectedByGravity = false
                physicsBody.velocity = SCNVector3Zero  // Ensure there's no residual physics velocity
            }
            // Move the ring to the new slider position
            ring.position.x = xPosition
            ring.position.z = zPosition
        }
    }
    
    func createScene(context: Context) -> SCNScene {
        let scene = SCNScene()
        // Apply gravity to the scene
        scene.physicsWorld.gravity = SCNVector3(0, -9.8, 0)
        // Add the room and rope/ring to the scene
        if let ringNode = room.addRoom(to: scene, coordinator: coordinator) {
            // Set the ringNode in the coordinator
            coordinator.setRingNode(ringNode)
            // Pass the scene to the coordinator
            coordinator.setScene(scene)
            
        } else {
            print("Error: ringNode could not be added to the scene.")
        }

        return scene
    }

}

