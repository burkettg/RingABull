/*
 * ContentView.swift
 * RingABull
 *
 * Testing with Git and Dad!
 *
 * Created by Greg and Nick Burkett on 9/29/24.
 *
 * I am creating this branch to play around in XCode and get a background going.
 */

import SwiftUI      //Import SwifUI framework - this is used to build user interfaces

//Here we want to declare a new struct that will be needed for the visual component/screen
struct ContentView: View {
    @State private var isGameActive = false     //State control of the game... is game play active.
    
    //Here is the main body of the contentView where elements of the UI are defined
    var body: some View {
        NavigationView{
            //A vertical stack that arranges the UI elements (Children) in a vertical line
            ZStack {
                
                //Here I will work with the background/background image
                Image("BackGroundImageV4")
                    .resizable()         //Make the image resizeable to the screen
                    .scaledToFill()      //Nees to make sure the image can fill the screen
                    .ignoresSafeArea()   //Makes the image cover the entire screen!
                
                //Next, I will work with the foreground content
                //Need to create a new VStack
                VStack{
                    
                    Text("Wlcome to Ring-A-Bull!")      //Text that says hello to user
                        .font(.largeTitle)              //Define the font of the text above
                        .fontWeight(.bold)              //Define the weight of the font
                        .foregroundColor(.white)        //Define the foreground color
                        .padding()                      //Add some padding after the text
                    
                }
                
                // Expands the ZStack to fill the entire screen
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 85)   //Need to add some padding after the welcome text
                
                //Need to create a vertical stack for the buttons to our home screen.
                VStack{
                    
                    //Define a button that will trigger the game play
                    Button(action: {
                        isGameActive = true     //Set the isGameActive flag to true
                    }){
                        Text("Start Game")      //Define what the button displays
                            .font(.title2)      //Define the font for the button's txt
                            .padding()                      //Add some padding
                            .frame(width: 150, height: 50)  //Define some frame dimensions
                            .background(Color.blue)         //Define the background color
                            .foregroundColor(.white)        //Define the foreground color
                            .cornerRadius(10)               //Define the corner radius of the button
                    }
                    
                    //Define a second button
                    Button(action: {
                        print("Settings!")      //Define the action of the button
                    }){
                        Text("SET LEVEL")       //Define the text that the button displays
                            .font(.title2)      //Define the font of the button
                            .padding(10)        //Add some padding around the button
                            .frame(width: 150, height: 50)      //Add a frame with dimensions
                            .background(Color.blue)             //Define a background color
                            .foregroundColor(.white)            //Define a foreground color
                            .cornerRadius(10)                   //Add the corner radius of the button
                    }
                }
                
            }
            
            //Here I will present the GameView modally as a full screen view when isGameActive = true
            .fullScreenCover(isPresented: $isGameActive){
                GameView()  //When isGameActive = true, call GameView() func
            }
        }
    }
}

#Preview {
    ContentView()
}
