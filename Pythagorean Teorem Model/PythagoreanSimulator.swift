//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/20/24.
//

import SwiftUI

struct PythagoreanSimulator: View {
    @State private var animate = false
    @State private var awidth = 250.0
    @State private var bwidth = 250.0
    
    @State private var speed = 1.0
    
    @State private var showabc = true
    
    
    
    var body: some View {
        PythagoreanAnimation(animate: $animate, speed: speed, showabc: showabc, aWidth: $awidth, bWidth: $bwidth)
            .contentShape(Rectangle())
            .onTapGesture {
                animate = true
            }
    }
}

#Preview {
    PythagoreanSimulator()
}
