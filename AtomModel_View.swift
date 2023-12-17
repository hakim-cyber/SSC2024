//
//  AtomModel_View.swift
//  SSC24
//
//  Created by aplle on 12/17/23.
//

import SwiftUI

struct AtomModel_View: View {
     let protonsCount = 8
    let neutron = 8
    @State private var electronCount = 8
    
    @State private var max = 2
    @State private var min = -2
    @State private var offsetForCustomization = 0.0
    @State private var showCustomization = true
    var body: some View {
        GeometryReader{geo in
            
            ZStack{
                
            }
            .padding(25)
           .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
            .overlay(alignment: .topTrailing) {
                ZStack{
                    if self.showCustomization{
                        
                        VStack(spacing: 20){
                            HStack{
                                Text("Atom")
                                    .bold()
                                    .font(.system(size: 20))
                                Spacer()
                                Text("O")
                            }
                            VStack{
                                Text("Electrons")
                                    .bold()
                                
                                HStack(spacing:15){
                                    Button("+"){
                                        if self.protonsCount - self.electronCount > self.min{
                                            self.electronCount += 1
                                            print("+")
                                        }
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .font(.system(size: 24))
                                    .bold()
                                    Button("-"){
                                        if self.protonsCount - self.electronCount < self.max{
                                            self.electronCount -= 1
                                            print("-")
                                        }
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .font(.system(size: 24))
                                    .bold()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                        .padding(30)
                        .background{
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(.regularMaterial)
                            
                        }
                        .frame(width: geo.size.width / 2.2 ,height: 250)
                        .offset(x:offsetForCustomization)
                        .transition(.move(edge: .trailing))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    self.offsetForCustomization = gesture.translation.width
                                })
                                .onEnded({ value in
                                    if value.translation.width > 10{
                                        withAnimation(.bouncy){
                                            self.showCustomization = false
                                        }
                                    }
                                })
                            
                        )
                    }else{
                        VStack{
                            Button{
                                withAnimation(.bouncy){
                                    self.showCustomization = true
                                    self.offsetForCustomization = 0
                                }
                               
                            }label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius:10)
                                        .fill(.regularMaterial)
                                    
                                    
                                    Image(systemName: "chevron.backward.2")
                                        .bold()
                                }
                                .frame(width:50,height: 150)
                            }
                        }
                        .transition(.push(from: .trailing))
                        .frame(height: 250)
                    }
                    
                }
            }
            
            
        }
        .padding(25)
       
        
    }
}

#Preview {
    AtomModel_View()
}
