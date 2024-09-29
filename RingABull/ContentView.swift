//
//  ContentView.swift
//  RingABull
//
//  Created by Greg Burkett on 9/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world! Bubba.")
            Spacer()
                .frame(height: 10)
            Text("Fun stuff.")
            Spacer()
                .frame(height: 10)
            Text("Fun stuff again.")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
