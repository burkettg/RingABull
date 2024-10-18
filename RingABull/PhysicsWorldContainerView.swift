//
//  PhysicsWorldContainerView.swift
//  RingABull
//
//  Created by Greg Burkett on 10/18/24.
//
import SwiftUI

struct PhysicsWorldContainerView: View {
    @Environment(\.dismiss) var dismiss  // For dismissing the full-screen view
    let currentWorldView: AnyView  // Inject the specific PhysicsWorldView here

    var body: some View {
        VStack {
            // SceneKit view using GeometryReader to adjust its size
            GeometryReader { geometry in
                let adjustedHeight = max(0, geometry.size.height - 45)  // Ensure positive height

                currentWorldView
                    .frame(width: geometry.size.width, height: adjustedHeight)  // Safe frame dimensions
                    .edgesIgnoringSafeArea(.top)
            }

            // "Go Home" button to dismiss the view
            Button(action: {
                dismiss()  // Dismiss the full-screen cover
            }) {
                Text("Go Home")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding([.leading, .trailing])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}




