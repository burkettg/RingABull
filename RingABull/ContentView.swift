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
    @State private var isGameActive = false     //State control of the game... is game play active.
    @State private var showingPhysicsWorld = false
    @State private var currentWorld = 1
    
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
                    
                    //Define a button that will trigger the game play
                    Button(action: {
                        showingPhysicsWorld = true     //Set the isGameActive flag to true
                    }){
                        Text("Take a Swing")      //Define what the button displays
                            .font(.title2)      //Define the font for the button's txt
                            .padding()                      //Add some padding
                            .frame(width: 170, height: 50)  //Define some frame dimensions
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
                    
                } // End VStack.
                
            } // End ZStack.
            //Here I will present the GameView modally as a full screen view when isGameActive = true
            .fullScreenCover(isPresented: $isGameActive){ GameView()  }
            // Greg added stuff..
            .fullScreenCover(isPresented: $showingPhysicsWorld, content: {
                // Add some configuration settings..
                //  ... blah blah ...
                
                //PhysicsWorldContainerView()
                PhysicsWorldContainerView(currentWorldView: getCurrentWorldView())
                    .onDisappear(perform: reset)
                   // .ignoresSafeArea()
                
            })
            
        } // End Navigation View.
        
    } // End Main Body.
    
    // Function to return the current world based on progression
        func getCurrentWorldView() -> AnyView {
            switch currentWorld {
            case 1:
                return AnyView(PhysicsWorldView_Level01())  // World 1
            case 2:
                return AnyView(PhysicsWorldView_Level01())  // World 2
            case 3:
                return AnyView(PhysicsWorldView_Level01())  // World 3
            default:
                return AnyView(PhysicsWorldView_Level01())  // Default to World 1 if unknown
            }
        }
    
}

func reset() {
    //  Change some settings, score, history ,etc..  stuff here..
    //  .. blah blah ...
    print("back to contentView from PhysicsWorldView_Level01.")
    
}

#Preview {
    ContentView()
}
