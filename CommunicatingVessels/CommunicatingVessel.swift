//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/24/24.
//

import SwiftUI

struct CommunicatingVessel: View {
    
    @State private var waveOffset = Angle.zero
    
    @State private var water = 75.0 //20 is zero
    var body: some View {
        ZStack{
            VStack{
                
                Spacer()
                ZStack{
                    Wave(offSet: waveOffset, percent: water)
                        .fill(Color.blue.opacity(0.85).gradient)
                        
                    Vessel2()
                        .fill(Color.brown)
                        .colorMultiply(.gray)
                   
                }
                    .frame(width: UIScreen.main.bounds.width,height: 400)
                    .clipped()
                   
            }
            
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.linear(duration: 3.5 ).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
        }
       
      
        
    }
}
/*
 #Preview {
 CommunicatingVessel()
 }
 */

struct Vessel1:Shape{
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: .zero)
        p.addLine(to: CGPoint(x: rect.width * 0.2, y: .zero ))
        p.addLine(to: CGPoint(x: rect.width * 0.1, y: rect.height * 0.75 ))
        
        p.addLine(to: CGPoint(x: rect.width * 0.8, y: rect.height * 0.75 ))
        
        p.addLine(to: CGPoint(x: rect.width * 0.9, y: .zero  ))
        p.addLine(to: CGPoint(x: rect.maxX , y: .zero  ))
        
        p.addLine(to: CGPoint(x: rect.maxX , y: rect.maxY  ))
        p.addLine(to: CGPoint(x: rect.minX , y: rect.maxY  ))
        p.addLine(to: CGPoint(x: rect.minX , y: rect.minY  ))
        
        
        p.move(to: CGPoint(x: rect.width * 0.3, y: .zero))
        
        p.addLine(to: CGPoint(x: rect.width * 0.375, y: rect.height * 0.25 * 2.5))
        
        p.addLine(to: CGPoint(x: rect.width * 0.575, y: rect.height * 0.25 * 2.5))
        p.addLine(to: CGPoint(x: rect.width * 0.5, y: .zero))
        
        p.addLine(to: CGPoint(x: rect.width * 0.3, y: .zero))
        
        return p
    }
    
    
}

struct Vessel2:Shape{
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        p.move(to: .zero)
        p.addLine(to: CGPoint(x: rect.width * 0.15, y: .zero ))
        
        p.addLine(to: CGPoint(x: rect.width * 0.15, y: rect.height * 0.75 ))
        
        p.addLine(to: CGPoint(x: rect.width * 0.75, y: rect.height * 0.75 ))
        
        p.addLine(to: CGPoint(x: rect.width * 7 * 0.125, y: rect.height * 0.45 ))
        p.addLine(to: CGPoint(x: rect.width * 13 / 16, y: rect.height * 0.3 ))
        p.addLine(to: CGPoint(x: rect.width * 7 * 0.125, y: rect.height * 0.15 ))
        p.addLine(to: CGPoint(x: rect.width * 13 / 16, y: .zero ))
        
        
        return p
    }
}
