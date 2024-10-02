/*
 * ContentView.swift
 * RingABull
 *
 * Created by Greg and Nick Burkett on 9/29/24.
 *
 * I am creating this branch to play around in XCode and get a background going.
 */
// change.
import SwiftUI      //Import SwifUI framework - this is used to build user interfaces

//Here we want to declare a new struct that will be needed for the visual component/screen
struct ContentView: View {
    
    //Here is the main body of the contentView where elements of the UI are defined
    var body: some View {
        
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
                
                Text("Wlcome to Ring-A-Bull!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Expands the ZStack to fill the entire screen
            .padding(.top, 85)      //Need to add the comment to the top and pad it
            
            //Need to create a vertical stack for the buttons to our home screen.
            VStack{
                Button(action: {
                    print("TIME TO HOOK EM!")
                }){
                    Text("PLAY GAME")
                        .font(.title2)
                        .padding(10)
                        .frame(width: 150, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    print("Settings!")
                }){
                    Text("SET LEVEL")
                        .font(.title2)
                        .padding(10)
                        .frame(width: 150, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()      //Add some padding
    }
}

#Preview {
    ContentView()
}
