//
//  File.swift
//  
//
//  Created by aplle on 1/23/24.
//

import SwiftUI

struct RadialLayout: Layout {
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard !subviews.isEmpty else { return }

        let radius = Swift.min(bounds.size.width, bounds.size.height) / 2
        let totalSubviews = subviews.count

        for (index, subview) in subviews.enumerated() {
            let angle = Double(index) * (2 * .pi) / Double(totalSubviews)

            let xPos = cos(angle) * radius
            let yPos = sin(angle) * radius

            let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}
