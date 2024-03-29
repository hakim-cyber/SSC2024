//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/27/24.
//

import SwiftUI

struct AtomModelAboutAnimation: View {
    
    var body: some View {
        GeometryReader{geo in
            AtomModel(size: CGSize(width: geo.size.width, height: geo.size.height), showOrbits: true, showProtonsNeutrons: true, scale: 0.85, offset: .zero, selectedAtomId:0 , electronCount: .constant(8))
                .position(x:geo.size.width / 2 ,y: geo.size.height / 2)
        }
    }
}

#Preview {
    AtomModelAboutAnimation()
        .preferredColorScheme(.dark)
}
