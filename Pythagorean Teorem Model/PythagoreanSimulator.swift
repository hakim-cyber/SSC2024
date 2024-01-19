//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/19/24.
//

import SwiftUI

struct PythagoreanSimulator: View {
    @State private var size = 200.0
    var body: some View {
        ZStack{
           
            
                    HStack(alignment:.bottom,spacing: 0){
                        Rectangle()
                            .frame(width: size / 2  ,height: size / 2 )
                  
                    Triangle()
                        .fill(.gray)
                        .frame(width:size / 2  * CGFloat(sqrt(3)), height: size / 2)
                        .overlay(alignment:.bottom){
                            Rectangle()
                                .frame(width: size / 2  * CGFloat(sqrt(3))   ,height: size / 2  * CGFloat(sqrt(3))  )
                                .rotationEffect(.degrees(180),anchor: .bottom)
                                
                        }
                    
                        Rectangle()
                            .frame(width: size   ,height: size  )
                            .rotationEffect(.degrees(-60),anchor: .bottomLeading)
                            
                    }
                   
                   
                
              
        }
    }
}

#Preview {
    PythagoreanSimulator()
}
