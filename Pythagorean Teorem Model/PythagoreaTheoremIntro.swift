//
//  PythagoreaTheoremIntro.swift
//  SSC24
//
//  Created by aplle on 1/9/24.
//

import SwiftUI

enum PythagoreanOptions:String, CaseIterable{
    case About,Simulator
    
    var image:Image{
        switch self {
        case .About:
            Image(systemName: "info")
        case .Simulator:
            Image(systemName: "play.fill")
        }
    }
}
struct PythagoreaTheoremIntro: View {
    @State private var screen = UIScreen.main.bounds
    
    @State private var selectedOption:PythagoreanOptions?
    var body: some View {
        
            VStack{
                
                Text("Pythagorean Theorem")
                    .bold()
                    .font(.system(size: 40,design: .monospaced))
                    .minimumScaleFactor(0.5)
                Spacer()
                Spacer()
                HStack(spacing: screen.width / 5){
                    ForEach(PythagoreanOptions.allCases,id:\.rawValue){option in
                        
                        Button{
                        }label:{
                            ZStack{
                                Circle()
                                VStack{
                                    option.image
                                        .foregroundStyle(Color.primary)
                                        .font(.system(size: screen.width / 23))
                                   
                                        
                                }
                                .padding(20)
                            }
                            .frame(width: screen.width / 10,height:  screen.width / 10)
                        }
                        
                    }
                }
                
                
                Spacer()
            }
            .padding(.vertical,30)
        
    }
}

#Preview {
    PythagoreaTheoremIntro()
}
