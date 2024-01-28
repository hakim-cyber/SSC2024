//
//  File.swift
//  
//
//  Created by aplle on 1/7/24.
//

import SwiftUI

struct CustomizationView<Content:View>:View {
    @Binding var show:Bool
    let size:CGSize
    @ViewBuilder var content:Content
    
    @State  var offsetForCustomization = 0.0
    var body: some View {
        ZStack{
            if self.show{
                content
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                .padding(30)
                .background{
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.regularMaterial)
                    
                }
                .overlay(alignment: .topLeading, content: {
                    Button{
                        withAnimation(.easeInOut){
                            self.offsetForCustomization = 0
                            self.show = false
                        }
                    }label:{
                       Image(systemName: "xmark")
                            .padding(15)
                            .font(.system(size: 20))
                    }
                })
                .frame(width:   Swift.min (size.height, size.width) / 1.5 )
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .offset(x:offsetForCustomization)
                .transition(.move(edge: .trailing))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            if value.translation.width > 10{
                                self.offsetForCustomization = value.translation.width
                            }else{
                               
                                self.offsetForCustomization = 0
                            }
                        })
                        .onEnded({ value in
                            if value.translation.width > 10{
                                withAnimation(.bouncy){
                                    self.show = false
                                }
                            }
                        })
                    
                )
                
            }else{
                VStack{
                    Button{
                        withAnimation(.bouncy){
                            self.show = true
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
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
        .padding(25)
        
    }
}


