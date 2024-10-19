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

    let room = Room(level: 3)
    
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
        
        // Ensure gravity is applied to the scene
        scene.physicsWorld.gravity = SCNVector3(0, -2.8, 0)  // Standard Earth gravity
        
        // Add the room (walls, floor, ceiling)
        room.addRoom(to: scene)
        
        
        
        return scene
    }
    
    


} // End struct


