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

struct WaveAnimationRectangle: View {
    let showWaterFall:Bool
    let percent :Double
    let name:String
    @State private var waveOffset = Angle(degrees: 0)
    
    var body: some View {
        GeometryReader{geo in
           
            ZStack{
                if  showWaterFall{
                    CurvedLine(reverse: false)
                        .stroke(.blue,style: .init(lineWidth: showWaterFall ? geo.size.width / 14 :4))
                        .frame(width:geo.size.width  , height:geo.size.height)
                        .transition(.asymmetric(insertion: .scale(scale:0.92).animation(.easeInOut(duration: 0.4)), removal: .identity))
                    CurvedLine(reverse: true)
                        .stroke(.blue,style: .init(lineWidth: showWaterFall ? geo.size.width / 14 :4))
                        .frame(width:geo.size.width  , height:geo.size.height)
                        .transition(.asymmetric(insertion: .scale(scale:0.92).animation(.easeInOut(duration: 0.4)), removal: .identity))
                       
                }
                
                Wave(offSet: Angle(degrees: waveOffset.degrees), percent: percent)
                    .fill(Color.blue)
                    .ignoresSafeArea(.all)
                    .padding(1.5)
                    .frame(width:geo.size.width , height:geo.size.height)
                
                
                Rectangle().stroke(lineWidth: 8)
                    .frame(width:geo.size.width , height:geo.size.height)
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
            
        }
        
        .overlay(content: {
            if name != ""{
                HStack(spacing:1){
                    Text(name)
                        .font(.system(size: 22))
                        .bold()
                    Text("2")
                        .font(.system(size:15))
                    
                        .baselineOffset(15)
                        .bold()
                }
                .bold()
                .foregroundStyle(.white)
            }
        })
        .onAppear {
            withAnimation(.linear(duration: showWaterFall ? 0.75 : 2).repeatForever(autoreverses: false)) {
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

