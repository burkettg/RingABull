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
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = createScene()
        
        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = UIColor.blue
        
        // Add Tap Gesture Recognizer to select the ring
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(CoordinatorButton.handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
        return sceneView
    }
    
    // MARK: Coordinator for gesture handling
    func makeCoordinator() -> CoordinatorButton {
        return CoordinatorButton(self)
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // Move the selected ring node based on slider values
        if let selectedNode = context.coordinator.selectedNode {
            selectedNode.position.x = xPosition
            selectedNode.position.z = zPosition
        }
    }
    
    func createScene() -> SCNScene {
        let scene = SCNScene()
        //let position = SCNVector3(0, 10, 0)
        
        // Add the room (walls, floor, ceiling)
        room.addRoom(to: scene)
        
        // Ensure gravity is applied to the scene
        scene.physicsWorld.gravity = SCNVector3(0, -4.8, 0)  // Standard Earth gravity
        
        return scene
    }
    
    
    
    


} // End struct


