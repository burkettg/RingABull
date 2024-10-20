//
//  CoordinatorButton.swift
//  RingABull
//
//  Created by Greg Burkett on 10/19/24.
//

import SwiftUI
import SceneKit

public class CoordinatorButton: NSObject {
        var parent: PhysicsWorldView_Level02
        var selectedNode: SCNNode?

        init(_ parent: PhysicsWorldView_Level02) {
            self.parent = parent
        }

    // Handle tap gesture (selecting the ring)
            @objc func handleTap(_ gesture: UITapGestureRecognizer) {
                guard let sceneView = gesture.view as? SCNView else { return }

                let location = gesture.location(in: sceneView)
                let hitResults = sceneView.hitTest(location, options: nil)

                // Debugging: Print hit test results
                print("Tap detected at: \(location), hit results: \(hitResults.count)")

                if let hit = hitResults.first(where: { $0.node.name == "ringNode" }) {
                    selectedNode = hit.node
                    selectedNode?.physicsBody?.isAffectedByGravity = false  // Disable physics while using sliders
                    parent.xPosition = selectedNode?.position.x ?? 0
                    parent.zPosition = selectedNode?.position.z ?? 0

                    // Debugging: Confirm ring is selected
                    print("Ring selected: \(String(describing: selectedNode?.name)) at position: \(String(describing: selectedNode?.position))")
                } else {
                    print("No ring was tapped.")
                }
            }

            // Function to release the ring (re-enable physics)
            func releaseRing() {
                selectedNode?.physicsBody?.isAffectedByGravity = true
                print("Ring released, physics re-enabled.")
                selectedNode = nil  // Clear the selection after release
            }
    
    
    
            
    }

