//
//  Coordinator.swift
//  RingABull
//
//  Created by Greg Burkett on 10/19/24.
//

import SwiftUI
import SceneKit

class Coordinator: NSObject {
        var parent: PhysicsWorldView_Level01?
        var selectedNode: SCNNode?

    // Properties to track the original touch location and node's position
        var originalWorldPosition: SCNVector3?
        var originalTouchLocation: CGPoint?
    
        init(_ parent: PhysicsWorldView_Level01) {
            self.parent = parent
        }

    // Handle pan gesture (dragging)
            @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
                guard let sceneView = gesture.view as? SCNView else { return }
                
                let location = gesture.location(in: sceneView)

                switch gesture.state {
                case .began:
                    // Hit test to see if the user tapped the ring
                    let hitResults = sceneView.hitTest(location, options: nil)
                    if let hit = hitResults.first(where: { $0.node.geometry is SCNTorus }) {
                        selectedNode = hit.node
                        selectedNode?.physicsBody?.isAffectedByGravity = false  // Disable physics while dragging
                        originalWorldPosition = selectedNode?.position
                        originalTouchLocation = location
                    }

                case .changed:
                    guard let selectedNode = selectedNode, let originalWorldPosition = originalWorldPosition, let originalTouchLocation = originalTouchLocation else { return }

                    // Convert the gesture’s location into 3D coordinates (world coordinates)
                    let currentTouchLocation = gesture.location(in: sceneView)
                    
                    // Calculate the movement offset between the original touch point and the current touch point
                    let deltaTouch = CGPoint(x: currentTouchLocation.x - originalTouchLocation.x, y: currentTouchLocation.y - originalTouchLocation.y)
                    
                    // Perform unprojection to get the new 3D position
                    let projectedOrigin = sceneView.projectPoint(originalWorldPosition)
                    let newProjectedPosition = SCNVector3(projectedOrigin.x + Float(deltaTouch.x), projectedOrigin.y - Float(deltaTouch.y), projectedOrigin.z)
                    let newWorldPosition = sceneView.unprojectPoint(newProjectedPosition)
                    
                    // Set the new position for the selected node (ring)
                    selectedNode.position = newWorldPosition

                case .ended, .cancelled:
                    guard let selectedNode = selectedNode else { return }
                    selectedNode.physicsBody?.isAffectedByGravity = true  // Re-enable physics

                    // Apply velocity based on swipe
                    let velocity = gesture.velocity(in: sceneView)
                    selectedNode.physicsBody?.velocity = SCNVector3(velocity.x * 0.01, -velocity.y * 0.01, 0)
                    self.selectedNode = nil  // Clear selection

                default:
                    break
                }
        }
    }
