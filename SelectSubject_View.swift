//
//  SelectSubject_View.swift
//  SSC24
//
//  Created by aplle on 12/17/23.
//

import SwiftUI

struct SelectSubject_View: View {
    var body: some View {
        NavigationStack{
            GeometryReader{geo in
                ZStack{
                    VStack{
                        Text("Select Subject")
                            .bold()
                            .font(.system(size: 60,design: .monospaced))
                            .minimumScaleFactor(0.5)
                        Spacer()
                        
                        HStack(spacing: 25){
                            
                            ForEach(Subjects.allCases, id:\.rawValue){subject in
                                NavigationLink(value: subject) {
                                    ZStack{
                                        Circle()
                                            .fill(subject.color.opacity(0.8))
                                        
                                        
                                        VStack(spacing: 15){
                                            Text(subject.rawValue.capitalized)
                                                .lineLimit(1)
                                                .foregroundStyle(.white)
                                                .bold()
                                                .font(.system(size: geo.size.width / 45,design: .monospaced))
                                                .fixedSize()
                                                .padding(.horizontal,10)
                                            subject.icon
                                                .foregroundStyle(.white)
                                                .bold()
                                                .font(.system(size: geo.size.width / 23,design: .monospaced))
                                                
                                        }
                                        .padding(25)
                                        
                                       
                                        
                                    }
                                    .frame(width:geo.size.width / (CGFloat(Subjects.allCases.count) + 1.5))
                                    
                                }
                                
                            }
                        }
                        Spacer()
                    }
                    
                }
                .padding(25)
                .padding(.horizontal,30)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
            }
            
        }
    }
}

#Preview {
    SelectSubject_View()
}
