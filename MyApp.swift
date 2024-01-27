import SwiftUI

@main
struct MyApp: App {
    
    var body: some Scene {
        WindowGroup {
           
            VStack{
               ContentView()
            }
            .sheet(isPresented: .constant(true), content: {
                AboutView(info: .pyfagore){
                    
                }
            })
            .preferredColorScheme(.dark)
          
        }
        
    }
}
