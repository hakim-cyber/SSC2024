//
//  SubjectCard.swift
//  SSC24
//
//  Created by aplle on 1/28/24.
//

import SwiftUI

struct SubjectCard: View {
    let info:AboutInfo
    
    var body: some View {
        let screen = UIScreen.main.bounds
        let min = min(screen.width, screen.height)
            GeometryReader{geo in
               
                ZStack{
                    info.color
                    
                    Blur(style: .dark)
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                        .cornerRadius(20)
                    info.cardImage.resizable().scaledToFit()
                       
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                      
                    ZStack{
                        Rectangle()
                            .fill(info.color.quaternary)
                        Blur(style: .systemChromeMaterial)
                            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                           
                        HStack{
                            Text(info.header)
                                .foregroundStyle(Color.primary)
                                .fontWeight(.heavy)
                                .fontDesign(.rounded)
                                .font(.system(size: 24))
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                .padding()
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Text("View")
                                .foregroundStyle(Color.accentColor)
                                .fontWeight(.black)
                                .fontDesign(.rounded)
                                .font(.system(size: 20))
                                .padding(.horizontal).padding(.vertical,10)
                                .background{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(info.color.quinary)
                                    
                                }
                        }
                        .padding()
                        .padding(.bottom)
                        
                    }
                    .frame(height:geo.size.height / 4)
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
                    .roundedCorner(20, corners: [.bottomLeft,.bottomRight])
                   
                    
                }
                .cornerRadius(20)
                   
            }
        
            .frame(width: min / 2.4 ,height:min / 2)
        .background{
            RoundedRectangle(cornerRadius: 20)
                .fill(info.color)
                
        }
        
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
