//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/20/24.
//

import SwiftUI

struct PythagoreanAnimation: View {

    @Binding var animate:Bool
    
    var speed:CGFloat = 1.0
    var showabc:Bool = true
   
    @Binding var aWidth:Double
    @Binding var bWidth:Double
    
    var showDots:Bool = true
    @State private var percentA = 105.0
    @State private var percentB = 105.0
    @State private var percentC =  -10.0
    
    @State private var rotate = -40.0
    
    
    
    @State private var showWaterFall = false
    
    @State private var screen = UIScreen.main.bounds
    var body: some View {
       
        GeometryReader{ geo in
            let size = geo.size
           
            let c = sqrt(aWidth * aWidth  + bWidth * bWidth)
            let rotation = asin(bWidth / c) * 180 / CGFloat.pi
            
            VStack(alignment: .center,spacing: 5){
                
                HStack(alignment:.bottom,spacing: 0){
                    WaveAnimationRectangle(showWaterFall: false, percent: percentA, name: !showabc ? "" : "a")
                        .frame(width:aWidth   ,height: aWidth   )
                        .rotationEffect(.degrees(-90))
                    Triangle()
                        .stroke(lineWidth: 1.5)
                        .frame(width:bWidth , height: aWidth)
                        .overlay(alignment:.bottom){
                            WaveAnimationRectangle(showWaterFall: false, percent: percentB, name: !showabc ? "" : "b")
                                .frame(width:bWidth   ,height: bWidth)
                                .rotationEffect(.degrees(180),anchor: .bottom)
                                .overlay(alignment: .bottomLeading, content: {
                                    if showDots && !self.animate{
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 25)
                                            .padding(-10)
                                            .gesture(
                                                DragGesture()
                                                    .onChanged({ value in
                                                        
                                                        
                                                        self.aWidth = min(250,max(100, aWidth + -value.translation.width / 15 + value.translation.height / 15))
                                                        self.bWidth = min(250,max(100, bWidth + -value.translation.width / 15 + value.translation.height / 15))
                                                        
                                                    })
                                                
                                                
                                                
                                            )
                                    }
                                })
                        }
                    
                    
                    WaveAnimationRectangle(showWaterFall: showWaterFall, percent: percentC, name: !showabc ? "" : "C")
                        .frame(width: c   ,height: c  )
                        
                        .overlay(alignment: .topTrailing, content: {
                            if showDots && !self.animate{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 25)
                                    .padding(-10)
                                    .gesture(
                                        DragGesture()
                                            .onChanged({ value in
                                                
                                                
                                                self.aWidth = min(250,max(100, aWidth + value.translation.width / 15 + value.translation.height / 15))
                                                
                                                
                                                
                                            })
                                        
                                        
                                        
                                    )
                            }
                        })
                        .overlay(alignment: .topLeading, content: {
                            if showDots && !self.animate{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 25)
                                    .padding(-10)
                                    .gesture(
                                        DragGesture()
                                            .onChanged({ value in
                                                
                                                
                                                
                                                self.bWidth = min(250,max(100, bWidth - value.translation.width / 15 + value.translation.height / 15))
                                                
                                                
                                            })
                                        
                                        
                                        
                                    )
                            }
                        })
                        .rotationEffect(.degrees(-90))
                        .rotationEffect(.degrees(-rotation),anchor: .bottomLeading)
                    
                    
                }
                .rotationEffect(.degrees(rotate),anchor: .center)
                
               
            }
            .position(x:size.width / 2,y:size.height / 2)
           
            
            .onChange(of: animate) {_, newValue in
                if newValue{
                    
                    withAnimation(.easeInOut(duration: 5.5).speed(speed)) {
                        
                        self.rotate = 135
                        
                    }completion: {
                        self.showWaterFall = false
                        self.animate = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 / speed){
                        withAnimation(.bouncy(duration: 5.5).speed(speed)){
                            self.showWaterFall = true
                            self.percentA = -10.0
                            self.percentC = 99.0 / CGFloat(sqrt(3))
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 / speed){
                        withAnimation(.bouncy(duration: 5.5).speed(speed)){
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
          
            
        }
       
        
      
        
        
                    
    }
}
