//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/7/24.
//

import SwiftUI

struct AtomInfoView: View {
    let atom:Atom
    let geoSize:CGSize
    let atomFacts: [String: String] = [
        "O": "Oxygen is essential for life and makes up a significant part of the Earth's atmosphere.",
        "H": "Hydrogen is the lightest and most abundant element in the universe.",
        "Al": "Aluminum is a lightweight and corrosion-resistant metal used in various applications.",
        "Si": "Silicon is a crucial element in the electronics industry and is a major component of Earth's crust.",
        "Ca": "Calcium is vital for the formation and maintenance of strong bones and teeth.",
        "Ge": "Germanium is used in semiconductor devices and fiber-optic systems.",
        "Cu": "Copper is an excellent conductor of electricity and is widely used in electrical wiring.",
        "Ag": "Silver has been used for centuries for its antibacterial properties and is a precious metal.",
        "Rh": "Rhodium is a rare and valuable metal, often used as a catalyst in chemical reactions."
    ]
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .padding(20)
        .background{
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.regularMaterial)
            
        }
        .frame(width: geoSize.width,height: geoSize.height)
        
        
    }
    
}

#Preview {
    AtomInfoView(atom: Atom.init(id: "H", proton: 1, neutron: 0, electron: 1, max: 1, min: -1), geoSize: CGSize(width: 600, height: 400))
}
