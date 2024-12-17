/*
 * ContentView.swift
 * RingABull
 *
 * Created by Greg and Nick Burkett on 9/29/24.
 *
 * I am creating this branch to play around in XCode and get a background going.
 */
// change.
import SwiftUI

struct ContentView: View {
    //State control of the game... is game play active.
    @State private var isGameActive = false
    @State private var showingPhysicsWorld = false
    // Set and retain current game level.
    @AppStorage("currentLevel") var currentGameLevel: Int = 1
    
    // Get ring position for control sliders.
    @State private var xPosition: Float = 0
    @State private var zPosition: Float = 0
        
    // Create the coordinator at this level
    @StateObject var coordinator = PhysicsWorldCoordinator()  // Now this coordinator is in scope
    
    var body: some View {
        NavigationView{
            
            ZStack {
                
                Image("BackGroundImageV4")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack{
                    
                    Text("Welcome to Ring-A-Bull!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 85)
                
                VStack{
                    
                    Spacer()
                    
                    Button(action: {
                        showingPhysicsWorld = true
                    }){
                        Text("Take a Swing")
                            .font(.title2)
                            .padding(10)
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                            .buttonStyle(.borderless)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.black, lineWidth: 2)
                            )
                    }
                    // Some preliminary options for different levels..  We have flexibility for evolution.
                    Menu {
                        Button("Cancel", action: { print("cancel") })
                        Button("Level_05", action: { currentGameLevel = 5 })
                        Button("Level_04", action: { currentGameLevel = 4 })
                        Button("Level_03", action: { currentGameLevel = 3 })
                        Button("Level_02", action: { currentGameLevel = 2 })
                        Button("Level_01", action: { currentGameLevel = 1 })
                    } label: {
                        Text("Set Level")
                    }
                    .font(.title2)
                    .padding(10)
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                    .buttonStyle(.borderless)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.black, lineWidth: 2)
                    )
                    
                    Spacer()
                    
                    Text("Current Level: \(currentGameLevel)")
                        .font(.title3)
                        .padding(10)
                        .frame(width: 200, height: 50)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                        .buttonStyle(.borderless)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.black, lineWidth: 2)
                        )
                    
                    Spacer()
                        .frame(height: 20)
                    
                } // End VStack.
                
            } // End ZStack.
            // This is the MAIN Game World Jump-in point..
            .fullScreenCover(isPresented: $showingPhysicsWorld, content: {
                // Add some configuration settings..
                
                //PhysicsWorldContainerView()
                PhysicsWorldContainerView( coordinator: coordinator )
                    .onDisappear(perform: reset)
                
            })
            
        } // End Navigation View.
        
    } // End Main Body.
    
    // Function to return the current world based on progression
        func getCurrentWorldView() -> AnyView {
            switch currentGameLevel {
            case 1: return AnyView(PhysicsWorldView_Level01(xPosition: $xPosition, zPosition: $zPosition, coordinator: coordinator))
            case 2: return AnyView(PhysicsWorldView_Level02(xPosition: $xPosition, zPosition: $zPosition, coordinator: coordinator))
            case 3: return AnyView(PhysicsWorldView_Level03(xPosition: $xPosition, zPosition: $zPosition, coordinator: coordinator))
            case 4: return AnyView(PhysicsWorldView_Level04(xPosition: $xPosition, zPosition: $zPosition, coordinator: coordinator))
            case 5: return AnyView(PhysicsWorldView_Level05(xPosition: $xPosition, zPosition: $zPosition, coordinator: coordinator))
            default: return AnyView(PhysicsWorldView_Level01(xPosition: $xPosition, zPosition: $zPosition, coordinator: coordinator))
            }
        }
    
} // End ContentView struct.

func reset() {
    //  Change some settings, score, history ,etc..  stuff here..
    //  .. blah blah ...
    print("back to contentView from PhysicsWorldView_Level01.")
    
}
