//
//  PhysicsWorldContainerView.swift
//  RingABull
//
//  Created by Greg Burkett on 10/18/24.
//
import SwiftUI
import SceneKit

struct PhysicsWorldContainerView: View {
    @Environment(\.dismiss) var dismiss  // For dismissing the full-screen view
    let currentWorldView: AnyView  // Inject the specific PhysicsWorldView here
    // Set and retain current game level.
    @AppStorage("currentLevel") var currentGameLevel: Int = 1
    
    // provide ring position to the view
    @State private var xPosition: Float = 0
    @State private var zPosition: Float = 0
    
    
    
    var body: some View {
        VStack {
            // SceneKit view using GeometryReader to adjust its size
            GeometryReader { geometry in
                let adjustedHeight = max(0, geometry.size.height - 45)  // Ensure positive height

                currentWorldView
                    .frame(width: geometry.size.width, height: adjustedHeight)  // Safe frame dimensions
                    .edgesIgnoringSafeArea(.top)
            }

            Spacer()
                .frame(height: 10)
            
            // Slider for moving the ring left/right (X axis)
            Text("Move Left/Right")
            Slider(value: $xPosition, in: -10...10, step: 0.1)
                .padding()

            // Slider for moving the ring forward/backward (Z axis)
            Text("Move Forward/Backward")
            Slider(value: $zPosition, in: -10...10, step: 0.1)
                .padding()

            // Button to release the ring and apply physics
            Button(action: {
                // Call the coordinator's release function
                if currentGameLevel == 2  {
                    let coordinator = PhysicsWorldView_Level02(xPosition: $xPosition, zPosition: $zPosition).makeCoordinator()
                    //coordinator.delegate as? coordinator
                    coordinator.releaseRing()
                }
            }) {
                Text("Release Ring")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            /*
             // Button to release the ring and apply physics
             Button(action: {
                 // Get the active coordinator through the SceneKit view
                 let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
                 let sceneView = keyWindow?.rootViewController?.view as? SCNView
                 let coordinator = sceneView?.delegate as? PhysicsWorldView_Level01.CoordinatorButton
                 coordinator?.releaseRing()
             }) {
                 Text("Release Ring")
                     .font(.headline)
                     .padding()
                     .background(Color.blue)
                     .foregroundColor(.white)
                     .cornerRadius(10)
             }
             */
            
            
            
            // "Go Home" button to dismiss the view
            Button(action: {
                dismiss()  // Dismiss the full-screen cover
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
            
            Spacer()
                .frame(height: 20)
            
        } // End VStack
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            print("just a comment in level 02")
            
           
        }
    }
}




