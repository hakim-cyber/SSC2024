//
//  AboutView.swift
//  SSC24
//
//  Created by aplle on 1/18/24.
//

import SwiftUI

struct AboutView: View {
    let info:AboutInfo
    var showSimulator:()-> Void
    @Environment(\.dismiss) var dismiss
    var body: some View {
        GeometryReader{geo in
            ScrollView{
                LazyVStack(spacing:20){
                    info.content
                        .scaledToFit()
                        .frame(width: geo.size.width,height:350)
                      
                        .background{
                            Color.init(uiColor: .systemBackground)
                                .ignoresSafeArea()
                        }
                    HStack{
                        Text(info.header)
                            .font(.system(size:30))
                            .fontWeight(.black)
                            .monospaced()
                            .padding(.horizontal)
                        Spacer()
                        Button{
                            // open simulator
                            dismiss()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                                showSimulator()
                            }
                        }label: {
                            HStack{
                                Text("Simulator")
                                    .font(.system(size:19))
                                Image( systemName: "arrow.up.forward")
                                    .font(.system(size:14))
                            }
                                
                           
                            .fontWeight(.black)
                            .padding(5)
                               
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.trailing,20)
                    }
                    HStack{
                        Text(info.aboutText)
                            .font(.system(size: 23))
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundStyle(Color.secondary)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                            .padding(.trailing,20)
                            .padding(.top)
                        Spacer()
                    }
                }
            }
            .scrollIndicators(.hidden)
            
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .overlay(alignment: .topTrailing) {
            Button{
                dismiss()
            }label: {
                Image(systemName: "xmark")
               .foregroundStyle(Color.accentColor)
               .font(.system(size: 18))
               .bold()
               .padding(13)
               .background(Circle().fill(Color.gray.opacity(0.15)))
               .padding()
       
            }
        }
    }
}
/*
#Preview {
    
    AboutView{
        Image("electron").resizable()
    }
}
*/
