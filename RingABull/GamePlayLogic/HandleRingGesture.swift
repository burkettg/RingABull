//
//  HandleRingGesture.swift
//  RingABull
//
//  Created by Greg Burkett on 10/19/24.
//

import SwiftUI
import SceneKit

struct HandleRingGesture: View {
    var body: some View {
        PhysicsWorldView_Level02()  // This now uses your SceneKit UIViewRepresentable
            .gesture(DragGesture()
                .onChanged { value in
                    handleDragChanged(value: value)
                }
                .onEnded { value in
                    handleDragEnded(value: value)
                }
            )
    }
    
    // Handle drag gesture
    func handleDragChanged(value: DragGesture.Value) {
        let location = value.location
        moveRingAtScreenPosition(location)
    }
    
    func handleDragEnded(value: DragGesture.Value) {
        releaseRing()
    }

    // Function to move the ring based on screen position
    func moveRingAtScreenPosition(_ screenPos: CGPoint) {
        guard let sceneView = getSCNView() else { return }
        
        // Hit test to detect the ring
        let hitResults = sceneView.hitTest(screenPos, options: nil)
        if let hit = hitResults.first(where: { $0.node.name == "ringNode" }) {
            // Disable physics to move manually
            hit.node.physicsBody?.isAffectedByGravity = false
            hit.node.physicsBody?.velocity = SCNVector3(0, 0, 0)

            // Move the ring to the new position
            let newPosition = hit.worldCoordinates
            hit.node.position = newPosition
        }
    }

    // Re-enable physics on the ring when released
    func releaseRing() {
        guard let sceneView = getSCNView() else { return }

        // Find the ring node and re-enable physics
        if let ringNode = sceneView.scene?.rootNode.childNode(withName: "ringNode", recursively: true) {
            ringNode.physicsBody?.isAffectedByGravity = true
        }
    }

    // Access the SCNView using UIWindowScene (iOS 15+)
    private func getSCNView() -> SCNView? {
        // Find the active UIWindowScene
        guard let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }),
              let sceneView = window.rootViewController?.view as? SCNView else {
            return nil
        }
        return sceneView
    }
}
