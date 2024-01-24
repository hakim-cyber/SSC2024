import SwiftUI

@main
struct MyApp: App {
    
    var body: some Scene {
        WindowGroup {
           
            VStack{
                CommunicatingVessel()
            }
            .preferredColorScheme(.dark)
          
        }
        
    }
}
