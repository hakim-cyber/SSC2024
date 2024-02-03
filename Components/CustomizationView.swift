//
//  File.swift
//  
//
//  Created by aplle on 1/7/24.
//

import SwiftUI

struct CustomizationView<Content:View>:View {
    @Binding var show:Bool
  
    @ViewBuilder var content:Content
    
    @State  var offsetForCustomization = 0.0
    var body: some View {
        ZStack{
                content
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                .padding(30)
        }
       
      
        
    }
}


