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
}

#Preview {
    GameView()
}
