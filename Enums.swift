//
//  Enums.swift
//  SSC24
//
//  Created by aplle on 12/17/23.
//


import SwiftUI

enum Subjects:String,CaseIterable,Hashable{
    case math,physics,  chemistry ,informatics
}
extension Subjects{
    var icon:Image{
        switch self {
        case .math:
            return Image(systemName: "x.squareroot")
        case .physics:
            return Image(systemName: "bolt")
        case .chemistry:
            return Image(systemName: "atom")
        case .informatics:
            return Image(systemName: "laptopcomputer")
        }
    }
    var color:Color{
        switch self {
        case .math:
            return Color.blue
        case .physics:
            return Color.green
        case .chemistry:
            return Color.red
        case .informatics:
            return Color.purple
        }
    }
}


