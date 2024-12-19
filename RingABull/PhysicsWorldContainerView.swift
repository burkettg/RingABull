//
//  PhysicsWorldContainerView.swift
//  RingABull
//
//  Created by Greg Burkett on 10/18/24.
//
import SwiftUI
import SceneKit

// This struct 'contains' the gameview and adds buttons.
// We can beef this up with game stats, etc..

struct PhysicsWorldContainerView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var coordinator = PhysicsWorldCoordinator()

    // Track the current game level
    @AppStorage("currentLevel") var currentGameLevel: Int = 1

    @State var xPosition: Float = 0
    @State var yPosition: Float = 0
    @State var zPosition: Float = 0
    @State var sceneView: SCNView? = nil  // Store the SCNView

    var body: some View {
        VStack {
            Spacer()

            // GeometryReader to handle SceneKit view
            GeometryReader { geometry in
                let adjustedHeight = max(0, geometry.size.height - 45)
                if let sceneView = sceneView {
                    SceneViewWrapper(sceneView: sceneView)
                        .frame(width: geometry.size.width, height: adjustedHeight)
                        .edgesIgnoringSafeArea(.top)
                } else {
                    Text("Loading Scene...")
                        .frame(width: geometry.size.width, height: adjustedHeight)
                        .background(Color.gray)
                        .edgesIgnoringSafeArea(.top)
                }
            }

            Spacer().frame(height: 10)

            // Slider for moving the ring left/right (X axis)
            Text("Move Left/Right")
            Slider(value: $xPosition, in: -10...10, step: 0.1)
                .padding()
                .onChange(of: xPosition) { _, newValue in
                    deactivateGravity()  // Ensure gravity is disabled when slider starts moving
                    moveRing(x: newValue, y: yPosition, z: zPosition)
                }
            
            // Slider for moving the ring forward/backward (Z axis)
            Text("Move Up/Down")
            Slider(value: $yPosition, in: -10...10, step: 0.1)
                .padding()
                .onChange(of: yPosition) { _, newValue in
                    deactivateGravity()  // Ensure gravity is disabled when slider starts moving
                    moveRing(x: xPosition, y: yPosition, z: newValue)
                }

            // Slider for moving the ring forward/backward (Z axis)
            Text("Move Forward/Backward")
            Slider(value: $zPosition, in: -10...10, step: 0.1)
                .padding()
                .onChange(of: zPosition) { _, newValue in
                    deactivateGravity()  // Ensure gravity is disabled when slider starts moving
                    moveRing(x: xPosition, y: yPosition, z: newValue)
                }
            
            Button(action: {
                releaseRing()  // Re-enable gravity when release button is pressed
            }) {
                Text("Release Ring")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                dismiss()
            }) {
                Text("Home from Level \(currentGameLevel)")
                    .font(.subheadline)
                    .frame(width: 200)
                    .frame(height: 45)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding([.leading, .trailing])
            }

            Spacer().frame(height: 20)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            setupRoomAndRing()
        }
    }

    // SceneKit wrapper for SwiftUI
    struct SceneViewWrapper: UIViewRepresentable {
        var sceneView: SCNView

        func makeUIView(context: Context) -> SCNView {
            return sceneView
        }

        func updateUIView(_ uiView: SCNView, context: Context) {}
    }

    func setupRoomAndRing() {
        let newSceneView = SCNView()
        let scene = SCNScene()
        newSceneView.scene = scene

        let room = Room(level: currentGameLevel)

        // Ensure the ringNode is non-optional
        guard let ringNode = room.addRoom(to: scene, coordinator: coordinator) else {
            print("Error: ringNode could not be created.")
            return
        }

        // Set the ringNode in the coordinator
        coordinator.setRingNode(ringNode)

        sceneView = newSceneView
    }

    // Move the ring manually, deactivating gravity and physics
    func moveRing(x: Float, y: Float, z: Float) {
        if let ringNode = coordinator.ringNode {
            ringNode.position.x = x
            ringNode.position.y = y
            ringNode.position.z = z
        }
    }

    // Deactivate gravity and physics when moving the ring
    func deactivateGravity() {
        // Disable gravity and reset forces for the ring
        if let ringNode = coordinator.ringNode {
            if let physicsBody = ringNode.physicsBody {
                physicsBody.isAffectedByGravity = false  // Disable gravity
                physicsBody.velocity = SCNVector3Zero  // Stop any movement
                physicsBody.angularVelocity = SCNVector4Zero  // Stop any rotation
                physicsBody.damping = 1.0  // Max out damping to reduce any residual movement
            }
        }

        // Disable gravity and forces for each rope segment
        for segment in coordinator.ropeSegments {
            if let segmentPhysicsBody = segment.physicsBody {
                segmentPhysicsBody.isAffectedByGravity = false  // Disable gravity
                segmentPhysicsBody.velocity = SCNVector3Zero  // Stop any velocity
                segmentPhysicsBody.angularVelocity = SCNVector4Zero  // Stop any angular velocity
                segmentPhysicsBody.damping = 1.0  // Max out damping to suppress any motion
            }
        }


        // Optionally, remove the constraints or joints temporarily if needed
        for joint in coordinator.joints {
            coordinator.removeJoint(joint)  // Remove the joint to stop it applying forces
        }
        
        //print("Physics and forces disabled for ring and rope segments.")
    }


    func releaseRing() {
        if let ringNode = coordinator.ringNode {
            if let physicsBody = ringNode.physicsBody {
                physicsBody.isAffectedByGravity = true  // Re-enable gravity
                physicsBody.damping = 0.1  // Reset damping to normal levels
                increaseVelocityForward()
            }
        }

        // Re-enable gravity and forces for each rope segment
        for segment in coordinator.ropeSegments {
            if let segmentPhysicsBody = segment.physicsBody {
                segmentPhysicsBody.isAffectedByGravity = true  // Re-enable gravity
                segmentPhysicsBody.damping = 0.1  // Reset damping to normal levels
                increaseVelocityForward()
            }
        }

        // Restore the joints or constraints
        for joint in coordinator.joints {
            coordinator.addJoint(joint)  // Re-add the joint to reactivate it
        }

        //print("Ring and rope segments released, physics enabled.")
    }
    
    func increaseVelocityForward() {
        guard let ringNode = coordinator.ringNode, let physicsBody = ringNode.physicsBody else { return }
        
        // Get the forward direction of the node in world space
        let forwardDirection = ringNode.presentation.worldTransform.forwardDirection
        
        // Adjust the force magnitude (higher for more acceleration)
        let forceMagnitude: Float = 200.0
        let force = SCNVector3(
            forwardDirection.x * forceMagnitude,
            forwardDirection.y * forceMagnitude,
            forwardDirection.z * forceMagnitude
        )
        
        // Apply the force to the physics body
        physicsBody.applyForce(force, asImpulse: false) // Continuous force for acceleration
    }

    
    
    
    

}



// Extension to get forward direction from an SCNMatrix4
extension SCNMatrix4 {
    var forwardDirection: SCNVector3 {
        // The negative Z-axis in SceneKit represents forward direction
        return SCNVector3(-m31, -m32, -m33)
    }
}
