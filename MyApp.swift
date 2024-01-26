import SwiftUI

@main
struct MyApp: App {
    
    var body: some Scene {
        WindowGroup {
           
            VStack{
                AtomModel_View()
            }
            .preferredColorScheme(.dark)
          
        }
        
    }
}
