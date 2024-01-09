//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/9/24.
//

import SwiftUI



struct PythagoreanAbout: View {
    @State private var percentA = 105.0
    @State private var percentB = 105.0
    @State private var percentC = -10.0
    
    @State private var rotate = -40.0
    var body: some View {
        HStack{
            VStack {
                        Triangle()
                   
                    .stroke(lineWidth: 5)
                   
                            .overlay(
                                ZStack{
                                    WaveAnimationRectangle(percent:percentC, name: "c" )
                                        .frame(width:200, height: 200)
                                     
                                        .rotationEffect(.degrees(210))
                                        .offset(x: 55, y: -90)
                                    
                                    WaveAnimationRectangle(percent:percentB, name: "b" )
                                   
                                         .frame(width:100 * CGFloat(sqrt(3)), height: 100 * CGFloat(sqrt(3)))
                                      .rotationEffect(.degrees(180))
                                         .rotationEffect(.degrees(0 ))
                                         .offset(x: 0, y: 145)
                                        
                                    
                                    WaveAnimationRectangle(percent:percentA ,name: "a")
                                         .frame(width:100 , height: 100)
                                      .rotationEffect(.degrees(180))
                                         .rotationEffect(.degrees(90 ))
                                         .offset(x: 30 - 100 * CGFloat(sqrt(3)) , y: 0)
                                }
                            )
                            .frame(width:100 * CGFloat(sqrt(3)), height: 100)
                            .overlay(alignment: .bottom){
                                Rectangle()
                                    .stroke(lineWidth: 5)
                                    .frame(width: 15, height: 15)
                                    .offset(x: 8 - 100 * CGFloat(sqrt(3)) / 2 )
                            }
                          
                    }
                   .rotationEffect(.degrees(rotate))
                    .padding()
                    .onAppear(perform: {
                        
                        withAnimation(.easeInOut(duration: 5.5)) {
                            
                            self.rotate = 150
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            withAnimation(.bouncy(duration: 5.5)){
                                self.percentA = -10.0
                                self.percentC = 99.0 / CGFloat(sqrt(3))
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            withAnimation(.bouncy(duration: 5.5)){
                                self.percentB = -10.0
                                self.percentC = 105.0
                            }
                        }
                         
                    })
                    .scaleEffect(1)
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

struct WaveAnimationRectangle: View {
    
    let percent :Double
    let name:String
    @State private var waveOffset = Angle(degrees: 0)
    
    var body: some View {
        ZStack {
           
            Wave(offSet: Angle(degrees: waveOffset.degrees), percent: percent)
                .fill(Color.blue)
                .ignoresSafeArea(.all)
                .padding(1.5)
           
            Rectangle().stroke(lineWidth: 8)
                
        }
        .overlay(content: {
            HStack(spacing:1){
                Text(name)
                  
                    .font(.system(size: 25))
                Text("2")
                    .font(.system(size: 15))
                    .baselineOffset(15)
                
            }
            .bold()
            .foregroundStyle(.white)
        })
        .onAppear {
            withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
        }
        .clipped()
    }
}

struct Wave: Shape {
    
    var offSet: Angle
    var percent: Double
    
   
    var animatableData: AnimatablePair<Double, Double> {
        get {
           AnimatablePair(Double(offSet.degrees), Double(percent))
        }

        set {
            offSet = Angle(degrees: newValue.first)
            percent = Double(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let lowestWave = 0.02
        let highestWave = 1.00
        
        let newPercent = lowestWave + (highestWave - lowestWave) * (percent / 100)
        let waveHeight = 0.015 * rect.height
        let yOffSet = CGFloat(1 - newPercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offSet
        let endAngle = offSet + Angle(degrees: 360 + 10)
        
        p.move(to: CGPoint(x: 0, y: yOffSet + waveHeight * CGFloat(sin(offSet.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yOffSet + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        p.closeSubpath()
        
        return p
    }
}

