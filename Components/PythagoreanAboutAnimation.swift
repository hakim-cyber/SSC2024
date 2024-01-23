//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/9/24.
//

import SwiftUI



struct PythagoreanAboutAnimation: View {
    
    @State private var animate = false
    
    var body: some View {
        ZStack{
           
            PythagoreanAnimation(animate: $animate, aWidth: .constant(42), bWidth: .constant(42 * sqrt(3)),showDots: false)
            
        }
        .blur(radius: animate ? 0:10)
        .onAppear(perform: {
            self.animate = true
        })
        .onDisappear{
            self.animate = false
        }
        .overlay(alignment: .center){
            if !animate {
                HStack{
                   
                    Button{
                        self.animate = true
                    }label: {
                        Image(systemName: "play.circle")
                            .bold()
                            .font(.system(size:40))
                           
                           
                    }
                   
                }
            }
            
            
        }
        
        
                    
    }
}
/*
 #Preview {
 PythagoreanAbout()
 }
 */

struct Triangle:Shape{
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        p.move(to: .zero)
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        return p
    }
}
struct CurvedLine:Shape{
    let reverse:Bool
    func path(in rect: CGRect) -> Path {
        var p = Path()
        if !reverse{
            p.move(to: .init(x: rect.maxX, y: rect.minY))
            p.addCurve(to:.init(x: rect.midX + 20, y: rect.maxY), control1: CGPoint(x: rect.midX + 30, y: rect.midY - 40), control2: CGPoint(x: rect.midX , y: rect.maxY))
        }else{
            p.move(to: .init(x: rect.minX, y: rect.minY))
            p.addCurve(to:.init(x: rect.midX  - 20, y: rect.maxY), control1: CGPoint(x: rect.midX - 30, y: rect.midY - 40), control2: CGPoint(x: rect.midX , y: rect.maxY))
        }
        return p
    }
}
