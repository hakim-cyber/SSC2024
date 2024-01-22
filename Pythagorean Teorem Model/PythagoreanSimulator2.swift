//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/19/24.
//

import SwiftUI

struct PythagoreanSimulator2: View {
    
    @State private var a = 50.0
    @State private var b = 50.0
    
    @State private var rotationEffect = 0.0
    
    var body: some View {
        ZStack{
           
            let c = sqrt(a * a  + b * b)
            let rotation = asin(b / c) * 180 / Double.pi
                    HStack(alignment:.bottom,spacing: 0){
                        Rectangle()
                            .fill(Color.green.opacity(0.4))
                            .stroke(Color.green,lineWidth: 3)
                           
                            .frame(width: a  ,height: a )
                  
                    Triangle()
                            .fill(.gray.opacity(0.4))
                        .frame(width:b, height: a)
                       
                        .overlay(alignment:.bottom){
                            Rectangle()
                                .fill(Color.green.opacity(0.4))
                                .stroke(Color.green,lineWidth: 3)
                                .frame(width:b   ,height: b  )
                                .rotationEffect(.degrees(180),anchor: .bottom)
                                .overlay(alignment: .bottomLeading, content: {
                                    Circle()
                                        .fill(.red)
                                        .frame(width: 20)
                                        .padding(-10)
                                        .gesture(
                                            DragGesture()
                                                .onChanged({ value in
                                                   
                                                       
                                                    self.a = min(300,max(100, a + -value.translation.width / 15 + value.translation.height / 15))
                                                            self.b = min(300,max(100, b + -value.translation.width / 15 + value.translation.height / 15))
                                                  
                                                })
                                                
                                        
                                        
                                        )
                                })
                        }
                       
                    
                        Rectangle()
                            .fill(Color.blue.opacity(0.4))
                            .stroke(Color.blue,lineWidth: 3)
                            .overlay(alignment: .topLeading, content: {
                                Circle()
                                    .fill(.green)
                                    .frame(width: 20)
                                    .padding(-10)
                                    .gesture(
                                        DragGesture()
                                            .onChanged({ value in
                                               
                                                   
                                                self.a = min(300,max(100, a + value.translation.width / 15 - value.translation.height / 15))
                                                       
                                               
                                                
                                            })
                                            
                                    
                                    
                                    )
                            })
                            .overlay(alignment: .bottomLeading, content: {
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 20)
                                    .padding(-10)
                                    .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    
                                        
                                   
                                    self.b = min(300,max(100, b - value.translation.width / 15 + value.translation.height / 15))
                                    
                                    
                                })
                                
                        
                        
                        )
                            })
                            .frame(width: c   ,height: c  )
                            .rotationEffect(.degrees(-rotation),anchor: .bottomLeading)
                           
                            
                    }
                  
                                   
                    .rotationEffect(.degrees(rotationEffect))
                   
            
                   
                   
                
              
        }
    }
}

#Preview {
    PythagoreanSimulator2()
}
