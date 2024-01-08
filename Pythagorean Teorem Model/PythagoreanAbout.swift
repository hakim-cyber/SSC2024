//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/9/24.
//

import SwiftUI



struct PythagoreanAbout: View {
    @State private var percentA = 90.0
    @State private var percentB = 90.0
    @State private var percentC = 0.0
    var body: some View {
        HStack{
            WaveAnimationRectangle(percent:percentA)
                .onAppear {
                    withAnimation(.bouncy(duration: 3.5)) {
                        self.percentA = -10
                        self.percentC = 30.0
                        
                    }
                }
                .frame(width: 150,height: 150)
            WaveAnimationRectangle(percent:percentB)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        withAnimation(.bouncy(duration: 3.5)) {
                            self.percentB = -10
                            self.percentC = 90.0
                        }
                    }
                }
                .frame(width: 200,height: 200)
            WaveAnimationRectangle(percent:percentC)
                .frame(width: 250,height: 250)
                
        }
    }
}
/*
 #Preview {
 PythagoreanAbout()
 }
 */


struct WaveAnimationRectangle: View {
    
    let percent :Double
    @State private var waveOffset = Angle(degrees: 0)
    
    var body: some View {
        ZStack {
           
            Wave(offSet: Angle(degrees: waveOffset.degrees), percent: percent)
                .fill(Color.blue)
                .ignoresSafeArea(.all)
                .padding(1.5)
           
            Rectangle().stroke(lineWidth: 2)
           
        }
       
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

