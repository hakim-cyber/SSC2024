import SwiftUI

@main
struct MyApp: App {
    
    var body: some Scene {
        WindowGroup {
           
            VStack{
                PythagoreanSimulator()
            }
            .preferredColorScheme(.dark)
          
        }
        
    }
}
