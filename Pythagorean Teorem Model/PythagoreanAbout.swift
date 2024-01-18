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
    @State private var percentC =  -10.0
    
    @State private var rotate = -40.0
    
    @State private var animate = false
    
    @State private var showWaterFall = false
    var body: some View {
        GeometryReader{ geo in
            let size = geo.size
            let modelSize = size.height  * 0.8
            
            VStack {
                Triangle()
                
                    .stroke(lineWidth: 5)
                
                    .overlay(
                        ZStack{
                            WaveAnimationRectangle(showWaterFall:showWaterFall, percent:percentC, name: "c" )
                                .frame(width:modelSize, height: modelSize)
                            
                                .rotationEffect(.degrees(210))
                                .offset(x: modelSize / 3.7, y: -modelSize / 2 + 8 )
                            
                            WaveAnimationRectangle(showWaterFall: false, percent:percentB, name: "b" )
                            
                                .frame(width:modelSize / 2 * CGFloat(sqrt(3)), height: modelSize / 2 * CGFloat(sqrt(3)))
                                .rotationEffect(.degrees(180))
                                .rotationEffect(.degrees(0 ))
                                .offset(x: 0, y: modelSize / 2  + 50)
                            
                            
                            WaveAnimationRectangle(showWaterFall: false, percent:percentA ,name: "a")
                                .frame(width:modelSize / 2 , height: modelSize / 2 )
                                .rotationEffect(.degrees(180))
                                .rotationEffect(.degrees(90 ))
                                .offset(x: 30 - modelSize / 2 * CGFloat(sqrt(3)) , y: 0)
                        }
                    )
                    .frame(width:modelSize / 2 * CGFloat(sqrt(3)), height: modelSize / 2)
                    .overlay(alignment: .bottom){
                        Rectangle()
                            .stroke(lineWidth: 5)
                            .frame(width: 15, height: 15)
                            .offset(x: 8 - modelSize / 2 * CGFloat(sqrt(3)) / 2 )
                    }
                
            }
            .rotationEffect(.degrees(rotate))
            .padding()
            .onAppear(perform: {
                
                self.animate = true
                
            })
            
            .onChange(of: animate) {_, newValue in
                if newValue{
                    
                    withAnimation(.easeInOut(duration: 5.5)) {
                        
                        self.rotate = 150
                        
                    }completion: {
                        self.showWaterFall = false
                        self.animate = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        withAnimation(.bouncy(duration: 5.5)){
                            self.showWaterFall = true
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
                }else{
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.rotate = -40
                        self.percentA = 105
                        self.percentC = -10
                        self.percentB = 105
                    }
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
            
            .scaleEffect(0.5)
            
        }
        .blur(radius: animate ? 0:10)
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
                        .stroke(.blue,style: .init(lineWidth: showWaterFall ? 5 :2))
                        .frame(width:geo.size.width  , height:geo.size.height)
                        .transition(.asymmetric(insertion: .scale(scale:0.7).animation(.easeInOut(duration: 0.4)), removal: .identity))
                    CurvedLine(reverse: true)
                        .stroke(.blue,style: .init(lineWidth: showWaterFall ? 10 :4))
                        .frame(width:geo.size.width  , height:geo.size.height)
                        .transition(.asymmetric(insertion: .scale(scale:0.7).animation(.easeInOut(duration: 0.55)), removal: .identity))
                       
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

