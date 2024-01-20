//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/20/24.
//

import SwiftUI

struct PythagoreanAnimation: View {

    @Binding var animate:Bool
    let aWidth:CGFloat
    let bWidth:CGFloat
    
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
            
            VStack(alignment: .center){
                
                HStack(alignment:.bottom,spacing: 0){
                    WaveAnimationRectangle(showWaterFall: false, percent: percentA, name: "a")
                        .frame(width:aWidth   ,height: aWidth   )
                        .rotationEffect(.degrees(-90))
                    Triangle()
                        .stroke(lineWidth: 1.5)
                        .frame(width:bWidth , height: aWidth)
                        .overlay(alignment:.bottom){
                            WaveAnimationRectangle(showWaterFall: false, percent: percentB, name: "b")
                                .frame(width:bWidth   ,height: bWidth)
                                .rotationEffect(.degrees(180),anchor: .bottom)
                            
                        }
                    
                    WaveAnimationRectangle(showWaterFall: showWaterFall, percent: percentC, name: "C")
                        .frame(width: c   ,height: c  )
                        .rotationEffect(.degrees(-90))
                        .rotationEffect(.degrees(-rotation),anchor: .bottomLeading)
                    
                    
                }
                .rotationEffect(.degrees(rotate),anchor: .bottom)
                
               
            }
            .position(x:size.width / 2,y:size.height / 2)
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
