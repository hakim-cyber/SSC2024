//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/25/24.
//

import SwiftUI

struct VesselSimulator: View {
    @State private var vesselWater = CGFloat(90.0)
    var body: some View {
        GeometryReader{geo in
            CommunicatingVessel(water: $vesselWater)
               
        }
        .frame(width: UIScreen.main.bounds.width + 5)
    }
}

#Preview {
    VesselSimulator()
}
