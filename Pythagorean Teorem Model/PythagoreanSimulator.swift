//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/20/24.
//

import SwiftUI

struct PythagoreanSimulator: View {
    @State private var animate = false
    @State private var awidth = 120.0
    @State private var bwidth = 160.0
    
    @State private var speed = 1.0
    
    @State private var showabc = true
    
    @State private var showCustomization = false
    
    @State private var scale = 1.0
    @State private var lastScale = 1.0
    
    @State private var offset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    
    var body: some View {
        GeometryReader{geo in
            let size = geo.size
            
            PythagoreanAnimation(animate: $animate, speed: speed, showabc: showabc, aWidth: $awidth, bWidth: $bwidth)
                .contentShape(Rectangle())
                .offset(x:offset.width,y:offset.height)
                .scaleEffect(scale)
                .gesture(
                               DragGesture()
                                   .onChanged { value in
                                       let translation = value.translation
                                       
                                       self.offset = CGSize(width: translation.width + lastOffset.width, height:translation.height + lastOffset.height)
                                   }
                                   .onEnded({ value in
                                       self.lastOffset = offset
                                   })
                                   .simultaneously(with:  MagnificationGesture()
                                       .onChanged { value in
                                           let scaleChange = value - 1
                                           let newScale =  Swift.min(Swift.max(scaleChange + lastScale, 0.2), 3)
                                           
                                           
                                          
                                               self.scale = newScale
                                       }
                                                   
                                       .onEnded({ value in
                                           
                                           self.lastScale = scale
                                       })
                                   )
                           )
                
            CustomizationView(show: $showCustomization, size: size) {
                VStack(spacing:25){
                    SliderWithText(value: $awidth, text: "Katet (a)", range: 100...250, step: 1.0)
                    SliderWithText(value: $bwidth, text: "Katet (b)", range: 100...250, step: 1.0)
                    
                    SliderWithText(value: $speed, text: "Speed", range: 0.1...4.0, step: 0.1)
                    
                    HStack{
                        Text("Show Name")
                            .bold()
                            .font(.system(size:  25)) // Set an initial font size
                            .minimumScaleFactor(0.5)
                        Spacer()
                        Toggle("", isOn: $showabc)
                    }
                    .padding(.vertical,10)
                    .contentShape(Rectangle())
                    
                    Button{
                        withAnimation(.easeInOut){
                            self.showCustomization = false
                            self.animate = true
                        }
                    }label: {
                        ZStack{
                            
                            Image(systemName: "play.fill")
                                .foregroundStyle(.white)
                                .bold()
                                .font(.system(size: 30))
                                
                            
                        }
                        .padding(30)
                        .background{
                            Circle()
                                .fill(Color.accentColor)
                                
                                
                        }
                       
                    }
                    .padding(.top,10)
                }
                .padding(.top,20)
                
            }
            
            VStack{
                Button{
                    withAnimation(.easeInOut){
                        self.offset = .zero
                    }
                }label:{
                    Image(systemName: "camera.metering.center.weighted")
                        .padding(20)
                        .background(Circle().fill(.regularMaterial))
                        .foregroundStyle(.primary)
                }
                .font(.system(size: 30))
                Button{
                    
                    withAnimation(.easeInOut){
                        self.scale += 0.1
                    }
                }label:{
                    Image(systemName: "plus.magnifyingglass")
                        .padding(20)
                        .background(Circle().fill(.regularMaterial))
                        .foregroundStyle(.primary)
                }
                .font(.system(size: 30))
                Button{
                    withAnimation(.easeInOut){
                        self.scale -= 0.1
                    }
                }label:{
                    Image(systemName: "minus.magnifyingglass")
                        .padding(20)
                        .background(Circle().fill(.regularMaterial))
                        .foregroundStyle(.primary)
                }
                .font(.system(size: 30))
                
            }
            .padding(.top)
        }
        .onChange(of: self.animate) {  _,newValue in
            if !newValue{
                withAnimation(.easeInOut){
                    self.showCustomization = true
                }
            }
        }
    }
}

/*
#Preview {
    PythagoreanSimulator()
}
*/

