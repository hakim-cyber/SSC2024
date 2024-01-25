//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/24/24.
//

import SwiftUI

struct CommunicatingVessel: View {
    
    
    
    @Binding var water:Double//20 is zero
    let density:Double
    
    @State private var waveOffset = Angle.zero
    @State private var screen = UIScreen.main.bounds
    
    @State private var waveTimer: Timer?
    var body: some View {
        ZStack{
            Color(red: 0.579, green: 0.898, blue: 0.972)
            VStack{
               

                
                Spacer()
                ZStack{
                    Wave(offSet: waveOffset, percent: water)
                        .fill(colorForWater())
                        .animation(.easeInOut, value: density)
                      
                        
                        
                        
                    Vessel2()
                        .fill(Color.brown)
                        .stroke(Color.white.opacity(0.6), lineWidth: 5)
                        .colorMultiply(.gray)
                        .overlay(alignment: .top) {
                            Vessel2Grass()
                                .stroke(Color.green.opacity(0.6), lineWidth: 8)
                                .frame(height: 12)
                                .offset(y:-12)
                               
                        }
                        
                   
                    
                }
                .frame(width: UIScreen.main.bounds.width + 7,height: screen.height / 2.7)
                .background{
                    Color.black
                }
                .clipped()
                    .offset(y:5)
                    
                   
            }
          
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity)
        .onAppear {
            waveTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                withAnimation(.linear(duration: 3.5)){
                    self.waveOffset += Angle(degrees: 60)
                }
            }
        }
        .onDisappear{
            self.waveTimer?.invalidate()
        }
       
      
        
    }
    
    func colorForWater()->Color{
        if density == 700{
            
            return Color.init(uiColor: .darkGray)
        }else if density > 1400{
            return Color.orange
        }else{
            return Color.blue
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
        p.move(to:  CGPoint(x: rect.width * 0.2, y: .zero ))
       
        p.addLine(to: CGPoint(x: rect.width * 0.1, y: rect.height * 0.75 ))
        
        p.addLine(to: CGPoint(x: rect.width * 0.8, y: rect.height * 0.75 ))
        
        p.addLine(to: CGPoint(x: rect.width * 0.9, y: .zero  ))
        p.move(to: CGPoint(x: rect.maxX , y: .zero  ))
        
        p.addLine(to: CGPoint(x: rect.maxX , y: rect.maxY  ))
        p.addLine(to: CGPoint(x: rect.minX , y: rect.maxY  ))
        p.addLine(to: CGPoint(x: rect.minX , y: rect.minY  ))
        
        
        p.move(to: CGPoint(x: rect.width * 0.3, y: .zero))
        
        p.addLine(to: CGPoint(x: rect.width * 0.375, y: rect.height * 0.25 * 2.5))
        
        p.addLine(to: CGPoint(x: rect.width * 0.575, y: rect.height * 0.25 * 2.5))
        p.addLine(to: CGPoint(x: rect.width * 0.5, y: .zero))
        
       
        
        return p
    }
    
    
}

struct Vessel1Grass:Shape{
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: .init(x: .zero, y: rect.maxY))
        p.addLine(to:  CGPoint(x: rect.width * 0.2, y: rect.maxY ))
        
        p.move(to: CGPoint(x: rect.width * 0.3, y: rect.maxY ))
        
        
        p.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.maxY ))
        
        
        p.move(to: CGPoint(x: rect.width * 0.9, y: rect.maxY  ))
        
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY  ))
        return p
    }
    
}

struct Vessel2:Shape{
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        p.move(to: CGPoint(x: rect.width * 0.15, y: .zero ))
       
        
        p.addLine(to: CGPoint(x: rect.width * 0.15, y: rect.height * 0.75))
        
        p.addLine(to: CGPoint(x: rect.width * 0.75, y: rect.height * 0.75 ))
        
        p.addLine(to: CGPoint(x: rect.width * 7 * 0.125, y: rect.height * 0.45 ))
        p.addLine(to: CGPoint(x: rect.width * 13 / 16, y: rect.height * 0.30 ))
        p.addLine(to: CGPoint(x: rect.width * 7 * 0.125, y: rect.height * 0.15 ))
        p.addLine(to: CGPoint(x: rect.width * 13 / 16, y: .zero ))
        
        
        p.move(to: CGPoint(x: rect.maxX, y: .zero))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        p.addLine(to: CGPoint(x:.zero, y: rect.maxY))
        
        p.addLine(to:.zero)
        
        
        p.move(to: CGPoint(x: rect.width * 0.25, y: .zero))
        p.addLine(to: CGPoint(x: rect.width * 0.25, y: rect.height * 0.6))
        p.addLine(to: CGPoint(x: rect.width * 5 / 16, y: rect.height * 0.6))
        p.addLine(to: CGPoint(x: rect.width * 5 / 16, y: .zero))
        
        
        p.move(to: CGPoint(x: rect.width * 6 / 16, y: .zero))
        p.addLine(to: CGPoint(x: rect.width * 6 / 16, y: rect.height * 0.6))
        p.addLine(to: CGPoint(x: rect.width * 7.5 / 16, y: rect.height * 0.6))
        p.addLine(to: CGPoint(x: rect.width * 9.5 / 16, y: .zero))
        
        p.move(to: CGPoint(x: rect.width * 11 / 16, y: .zero))
        p.addLine(to: CGPoint(x: rect.width * 9 / 16, y: rect.height * 0.6))
        p.addLine(to: CGPoint(x: rect.width * 11.75 / 16, y: rect.height * 0.6))
       
        p.addLine(to: CGPoint(x:  rect.width * 12.75 / 16, y: rect.height * 0.45 ))
        p.addLine(to: CGPoint(x:  rect.width * 11.75 / 16, y: rect.height * 0.30 ))
        p.addLine(to: CGPoint(x: rect.width * 12.75 / 16, y: rect.height * 0.15 ))
        
        p.addLine(to: CGPoint(x: rect.width * 11.75 / 16, y: .zero))
       
        
        return p
    }
}

struct Vessel2Grass:Shape{
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: .init(x: .zero, y: rect.maxY))
        p.addLine(to:  CGPoint(x: rect.width * 0.15, y: rect.maxY ))
        
        p.move(to: CGPoint(x: rect.width * 0.25, y: rect.maxY ))
        
        
        p.addLine(to: CGPoint(x: rect.width * 5 / 16, y: rect.maxY ))
        
        
        p.move(to: CGPoint(x: rect.width * 6 / 16, y: rect.maxY))
        
        p.addLine(to: CGPoint(x: rect.width * 9.5 / 16, y: rect.maxY))
        
        
        p.move(to: CGPoint(x: rect.width * 11 / 16, y: rect.maxY))
        
        p.addLine(to: CGPoint(x: rect.width * 11.75 / 16, y: rect.maxY))
        
      
        p.move(to: CGPoint(x: rect.width * 13 / 16 , y: rect.maxY ))
        
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY ))
       
        return p
    }
    
}
