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

    let room = Room(level: 1)
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = createScene()
        
        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = UIColor.blue
        
        // Add Pan Gesture Recognizer to detect dragging
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(_:)))
        sceneView.addGestureRecognizer(panGesture)
        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
    
    func createScene() -> SCNScene {
        let scene = SCNScene()
        
        // Ensure gravity is applied to the scene
        scene.physicsWorld.gravity = SCNVector3(0, -4.8, 0)  // Standard Earth gravity
        
        // Add the room (walls, floor, ceiling)
        room.addRoom(to: scene)
        
        
        
        return scene
    }
    
    // MARK: Coordinator for gesture handling
       func makeCoordinator() -> Coordinator {
           return Coordinator(self)
       }
    
    
    


} // End struct



