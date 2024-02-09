//
//  SelectSubject_View.swift
//  SSC24
//
//  Created by aplle on 12/17/23.
//

import SwiftUI

struct Start_View: View {
    @State private var selected:AboutInfo? = nil
    @State private var path = NavigationPath()
    @State var screen = UIScreen.main.bounds
    var body: some View {
        NavigationStack(path: $path){
            let min = min(screen.width, screen.height)
            ScrollView(.vertical,showsIndicators: false){
                HStack{
                    Spacer()
                    Text("Scientific Wonders: From Pythagoras to Atoms")
                        .fontWeight(.heavy)
                        .font(.system(size: 26))
                        .minimumScaleFactor(0.5)
                        .fontDesign(.rounded)
                        
                        
                    Spacer()
                    
                }
                .padding([.horizontal,.top],min / 10)
                HStack{
                    Spacer()
                    let grid =  [GridItem(.adaptive(minimum: min / 2.3, maximum: min / 2.3))]
                    LazyVGrid(columns:grid){
                        
                        
                        
                        
                        
                        ForEach(AboutInfo.allCases, id:\.rawValue){info in
                            Button{
                                withAnimation {
                                    self.selected = info
                                }
                            }label: {
                                SubjectCard(info: info)
                                    .padding(.bottom,20)
                            }
                            
                        }
                        
                        
                    }
                    
                    .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
                    .padding(.top,70)
                    Spacer()
                }
            }
            .navigationDestination(for: AboutInfo.self) { info in
                switch info {
                case .atomModel:
                    AtomModel_Simulator()
                case .communicatingVessels:
                    VesselSimulator()
                case .pyfagore:
                    PythagoreanSimulator()
                }
            }
            
        }
       
        
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .sheet(item: $selected) { selected in
            AboutView(info: selected) {
                withAnimation {
                    path.append(selected)
                }
            }
        }
    }
    
    
}


#Preview {
    Start_View()
}
