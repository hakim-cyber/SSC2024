//
//  File.swift
//  
//
//  Created by aplle on 1/23/24.
//

import SwiftUI

struct SliderWithText:View {
    @Binding var value:Double
    let text:String
    let range:ClosedRange<Double>
    let step:Double
    var body: some View {
        VStack(spacing: 5){
            HStack{
                Text(text)
                    .bold()
                    .font(.system(size:  25)) // Set an initial font size
                    .minimumScaleFactor(0.5)
                Spacer()
                HStack(alignment: .center){
                    
                    Text(String(format: "%.2f", value))
                        .scaledToFit()
                        .bold()
                        .font(.system(size:  20)) // Set an initial font size
                        .minimumScaleFactor(0.5)
                        .padding(3)
                        .foregroundStyle(.white)
                        .fixedSize()
                    
                }
            }
           
            Slider(value: $value,in:range,step: step)
                
        }
        .padding(.vertical,10)
        
    }
}
