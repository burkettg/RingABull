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
        
        //Create a VStack to hold my screens objects... in a way
        VStack {
            Text("This is the second screen!")      //Display text on the screen
                .font(.largeTitle)                  //Define the font for the text
                .padding()                          //Add some padding
            
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
        }
    }
}

#Preview {
    GameView()
}
