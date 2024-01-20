//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/20/24.
//

import SwiftUI

struct PythagoreanSimulatorAnimation: View {
    @State private var animate = false
    @State private var awidth = 50.0
    @State private var bwidth = 50.0
    var body: some View {
        PythagoreanAnimation(animate: $animate, aWidth: awidth, bWidth: bwidth)
    }
}

#Preview {
    PythagoreanSimulatorAnimation()
}
