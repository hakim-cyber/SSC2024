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
   
    var factForAtom:String{
        atomFacts[atom.id] ?? ""
    }
    var colorForAtom:String{
        colors[atom.id] ?? ""
    }
    var discovery:String{
        discoveries[atom.id] ?? ""
    }
    var body: some View {
        ZStack{
            VStack(spacing: 20){
                HStack(spacing: 20){
                    atomName
                    
                    Text(atom.fullName)
                        .fontWeight(.heavy)
                        .font(.system(size: geoSize.width / 25))
                       
                    Spacer()
                }
                .padding(6)
                Text(factForAtom)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: geoSize.width / 33))
                    .fontWeight(.bold)
                    .monospaced()
                   
                Rectangle()
                     .frame(width: geoSize.width,height: 1)
                     .tint(Color.primary)
                Group{
                    aboutString(title: "Color", value: colorForAtom)
                    aboutString(title: "Discovery Year", value: discovery)
                }
                .padding(.leading,8)
                Rectangle()
                     .frame(width: geoSize.width,height: 1)
                     .tint(Color.primary)
                Group{
                    about(title: "Atomic Number", value: CGFloat(atom.proton))
                    about(title: "Neutrons Count", value: CGFloat(atom.neutron))
                    about(title: "Mass", value: CGFloat(atom.mass))
                    about(title: "Group", value: CGFloat(atom.group))
                    
                }
                .padding(.leading,8)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .padding(19)
        .background{
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.regularMaterial)
            
        }
        .frame(width: geoSize.width)
        .fixedSize(horizontal: false, vertical: true)
        
        
    }
    var atomName:some View{
        ZStack{
            Text("\(atom.id)")
                .bold()
                .font(.system(size: geoSize.width / 30))
                .foregroundStyle(.primary)
                .padding(10)
                .padding(.horizontal,6)
        }
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.primary,lineWidth: 2))
    }
    func about(title:String,value:CGFloat)->some View{
        HStack(spacing: 10){
            Text(title + ":" + " \(value.formatted())")
                .font(.system(size: geoSize.width / 37))
                .fontWeight(.bold)
                .monospaced()
            Spacer()
        }
    }
    func aboutString(title:String,value:String)->some View{
        HStack(spacing: 10){
            Text(title + ":" + " \(value)")
                .font(.system(size: geoSize.width / 37))
                .fontWeight(.bold)
                .monospaced()
            Spacer()
        }
    }
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
    let colors: [String: String] = [
        "O": "Red",
        "H": "Blue",
        "Al": "Gray",
        "Si": "Green",
        "Ca": "Orange",
        "Ge": "Purple",
        "Cu": "Brown",
        "Ag": "Silver",
        "Rh": "Yellow"
    ]
    let discoveries: [String: String] = [
        "O": "1774",
        "H": "1766",
        "Al": "1825",
        "Si": "1824",
        "Ca": "1808",
        "Ge": "1886",
        "Cu": "Ancient",
        "Ag": "Ancient",
        "Rh": "1803"
    ]
}

#Preview {
    AtomInfoView(atom: Atom.init(id: "H",fullName: "Hydrogen", proton: 1, neutron: 0, electron: 1, max: 1, min: -1, group: 1), geoSize: CGSize(width: 800, height: 500))
}
