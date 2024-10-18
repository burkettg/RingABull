//
//  GameView.swift
//  RingABull
//
//  Created by Nick Burkett on 9/30/24.
//

import Foundation       //Import the foundation library
import SwiftUI          //Import the SwiftUI library/framework

//Create a struct for the GameView
struct GameView: View {
    
    //Need to create a few variables for the physics world
    @State private var angle: Double = 0            //Angle for the swing motion
    @State private var swingDirection: Double = 1   //Control the direction of the Swing
    @State private var isSwinging: Bool = false     //Know if the swing is active or not
    
    //Here I will create a new variable of a Environment wrapper to dismiss my views when needed.
    @Environment(\.dismiss) var dismiss
    
    var body: some View{
        
        ZStack{
            
            //Here I will work with the background/background image
            Image("GameMode00")
                .resizable()         //Make the image resizeable to the screen
                .scaledToFill()      //Nees to make sure the image can fill the screen
                .ignoresSafeArea()   //Makes the image cover the entire screen!
            
            //Create a VStack to hold my screens objects... in a way
            VStack {
                Spacer()
                
                //Need to draw the rope... A simple line will work for now.
                Path { path in
                    path.move(to: CGPoint(x: UIScreen.main.bounds.width / 2, y: 100))
                    path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2, y: 250))
                }
                .stroke(Color.brown, lineWidth: 4)
                
                //Now I need to create the ring that attaches to the rope
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.gray)
                    .rotationEffect(.degrees(angle))    //Rotate the ring as it swings
                    .offset(x: angle == 0 ? 0: CGFloat(angle * 2))
                    .gesture(DragGesture()
                        .onEnded({ value in
                            withAnimation(.easeInOut(duration: 1)) {
                                isSwinging.toggle()
                                swingDirection *= -1
                                startSwinging()
                            }
                            }))
                
                Spacer()
                
                //Define a button
                Button(action: {
                    
                    //When the user clicks this button, the action will be to dismiss the screen/current view
                    dismiss()
                }){
                    Text("End Game")             //Display text on the screen
                        .font(.headline)         //Define the font for the text
                        .padding()               //Add padding around the text
                        .frame(width: 150, height: 40)      //Add a frame with some dimensions
                        .background(Color.red)              //Define the background color
                        .foregroundColor(.white)            //Define the foreground color
                        .cornerRadius(10)                   //Define the radius of the button
                        
                }
                .padding(.bottom, 10)
                
            }
            
        }
        
    }
    
    func startSwinging(){
        if isSwinging {
            withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)){
                angle = swingDirection * 60        //Swing back and forth between -30 and 30 degrees
            }
        }
        else{
            withAnimation(.easeInOut(duration: 1)){
                angle = 0       //Stop swinging
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
