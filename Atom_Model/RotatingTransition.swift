//
//  File.swift
//  
//
//  Created by aplle on 1/23/24.
//

import SwiftUI

struct RotatingTransition: ViewModifier {
    var angle: Double

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(angle))
            .transition(.scale)
    }
}

extension AnyTransition {
    static func rotating(angle: Double) -> AnyTransition {
        AnyTransition.modifier(
            active: RotatingTransition(angle: angle),
            identity: RotatingTransition(angle: 0)
        )
    }
}
