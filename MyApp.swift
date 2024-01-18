import SwiftUI

@main
struct MyApp: App {
    
    var body: some Scene {
        WindowGroup {
            VStack{
                
            }
            .sheet(isPresented: .constant(true), content: {
                AboutView(info:.atomModel){
                    
                }
            })
            .preferredColorScheme(.dark)
        }
    }
}
