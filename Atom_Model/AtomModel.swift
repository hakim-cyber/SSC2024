//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/27/24.
//

import SwiftUI

struct AtomModel: View {
    
    let size:CGSize
    let showOrbits:Bool
    let showProtonsNeutrons:Bool
    let scale:CGFloat
    let offset:CGSize
    let selectedAtomId:Int
    
    @State  var protonsCount = 1
    @State private var neutron = 1
    @Binding var electronCount:Int
    
    @State private  var max = 0
    @State private var min = 0
    
    @State private var neutronPositions: [CGSize] = []
       @State private var protonPositions: [CGSize] = []
    
    
    @State private var generated = false
    
   
    @State private var screen = UIScreen.main.bounds.size
    
  
    
    var body: some View {
        ZStack{
            let orbitsCount = numberOfOrbits(forElectrons: electronCount)
            ZStack{
                core(geoSize: size)
               
                ZStack{
                  
                   
                    
                    ForEach(1...orbitsCount,id:\.self){id in
                       
                        AtomModelOrbit(geoSize: size, id:CGFloat(id),electronCount:electronCount, show: showOrbits)
                    }
                }
               
                
            }
            
            .contentShape(Circle())
           
            .animation(.easeInOut, value: selectedAtomId)
            
            .frame(maxWidth: .infinity,maxHeight:.infinity,alignment:.center)
            .offset(x:offset.width,y:offset.height)
            .scaleEffect(scale * Double(1.0 / (Double(orbitsCount) / 3.0)))
        }
        .onAppear {
                     
            let selected = atoms[selectedAtomId]
            
            
            self.protonsCount = selected.proton
            self.electronCount = selected.electron
            self.neutron = selected.neutron
            self.max = selected.max
            self.min = selected.min
          
            if !generated{
                self.generateRandomPositions(geoSize: size)
            }
            
                  }
        .onChange(of: selectedAtomId) { _,newvalue in
            if newvalue >= 0 && newvalue <= self.atoms.count - 1{
                let selected = atoms[newvalue]
                
                
                self.protonsCount = selected.proton
                self.electronCount = selected.electron
                self.neutron = selected.neutron
                self.max = selected.max
                self.min = selected.min
              
            
                self.generateRandomPositions(geoSize: size)
              
            }
        }
    }
    func numberOfOrbits(forElectrons electrons: Int) -> Int {
        var orbitCount = 0
            var remainingElectrons = electronCount

            while remainingElectrons > 0 {
                let electronsInCurrentOrbit = 2 * orbitCount * orbitCount

                if remainingElectrons >= electronsInCurrentOrbit {
                    remainingElectrons -= electronsInCurrentOrbit
                    orbitCount += 1
                } else {
                    break
                }
            }
       
        return Swift.max(orbitCount , 1)
       
        
    }
    func circle(string:String,color:Color,width:CGFloat)->some View{
        ZStack{
            Circle()
                .fill(color)
                .overlay(alignment: .center) {
                    Text(string)
                        .font(.system(size: width / 2.5))
                        .bold()
                }
                .frame(width: width * 0.8,height: width * 0.8)
        }
       
    }
    func core(geoSize: CGSize) -> some View {
        let width = Swift.min(geoSize.width,geoSize.height) / 6
          return  ZStack {
                if generated && self.showProtonsNeutrons{
                    ForEach(0..<neutron, id: \.self) { id in
                        circle(string: "",
                               color: .yellow,
                               width: Swift.min(width / CGFloat((neutron + protonsCount)) * 3, geoSize.width / 23))
                        .offset(neutronPositions[id])
                    }
                    ForEach(0..<protonsCount, id: \.self) { id in
                        circle(string: "+",
                               color: .green,
                               width: Swift.min(width / CGFloat((neutron + protonsCount)) * 3, geoSize.width / 23))
                        .offset(protonPositions[id])
                    }
                }else{
                    let selected = atoms[selectedAtomId]
                    circle(string: "\(selected.id)", color: .blue, width: geoSize.width / 6.0 / 3.4).foregroundStyle(.white)
                }
            }
            .frame(width:width)
        }

        private func generateRandomPositions(geoSize: CGSize) {
            generated = false
            neutronPositions = (0..<neutron).map { _ in
                CGSize(width: .random(in: -geoSize.width / 22 ... geoSize.width / 22), height: .random(in: -geoSize.width / 22 ... geoSize.width / 22))
            }

            protonPositions = (0..<protonsCount).map { _ in
                CGSize(width: .random(in: -geoSize.width / 22 ... geoSize.width / 22), height: .random(in: -geoSize.width / 22 ... geoSize.width / 22))
            }
            generated = true
        }
    
    let atoms: [Atom] = [
        Atom(id: "O", fullName: "Oxygen", proton: 8, neutron: 8, electron: 8, max: 2, min: -2, group: 16),
        Atom(id: "H", fullName: "Hydrogen", proton: 1, neutron: 0, electron: 1, max: 1, min: -1, group: 1),
        Atom(id: "Al", fullName: "Aluminum", proton: 13, neutron: 14, electron: 13, max: 3, min: 0, group: 13),
        Atom(id: "Si", fullName: "Silicon", proton: 14, neutron: 14, electron: 14, max: 4, min: -4, group: 14),
        Atom(id: "Ca", fullName: "Calcium", proton: 20, neutron: 20, electron: 20, max: 2, min: 0, group: 2),
        Atom(id: "Ge", fullName: "Germanium", proton: 32, neutron: 41, electron: 32, max: 4, min: 0, group: 14),
        Atom(id: "Cu", fullName: "Copper", proton: 29, neutron: 35, electron: 29, max: 4, min: 0, group: 11),
        Atom(id: "Ag", fullName: "Silver", proton: 47, neutron: 61, electron: 47, max: 3, min: 0, group: 11),
        Atom(id: "Rh", fullName: "Rhodium", proton: 45, neutron: 58, electron: 45, max: 6, min: -1, group: 9)
    ]
}

/*
#Preview {
    AtomModel(size: CGSizeMake(200, 200), showOrbits: true, showProtonsNeutrons: false, scale: 0.5, offset: .zero, selectedAtomId: 0)
}
*/
