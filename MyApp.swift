import SwiftUI
import TipKit

@main
struct MyApp: App {
  
    var body: some Scene {
        WindowGroup {
           
            VStack{
                Start_View()
                
                    .onAppear(perform: {
                        
                        try? Tips.resetDatastore()
                        try?  Tips.configure()
                    })
            }
           
            .preferredColorScheme(.dark)
          
        }
        
    }
}
