//
//  AtomModel_View.swift
//  SSC24
//
//  Created by aplle on 12/17/23.
//

import SwiftUI

struct AtomModel_View: View {
    
    @State private var neutronPositions: [CGSize] = []
       @State private var protonPositions: [CGSize] = []
    
    @State private var generated = false
    @State  var protonsCount = 1
    @State private var neutron = 0
    @State  var electronCount = 1
    
    @State  var max = 1
    @State  var min = -1
    @State  var offsetForCustomization = 0.0
    @State  var offsetForInfo = 0.0
    @State  var showCustomization = false
    
    @State  var showInfo = false
    
    @State  var showProtonsNeutrons = true
    
    @State  var selectedAtomId:Int = 1
    
    @State  var showOrbits = true
    
    @State private var screen = UIScreen.main.bounds.size
    
  
    
    
    @State private var scale = 0.5
    @State private var lastScale = 0.5
    
    @State private var offset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    var body: some View {
        GeometryReader{geo in
            let size = geo.size
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
                .transition(.rotating(angle: 90))
                .contentShape(Circle())
                .animation(.easeInOut, value: orbitsCount)
                .animation(.easeInOut, value: selectedAtomId)
                
                .frame(maxWidth: .infinity,maxHeight:.infinity,alignment:.center)
                .offset(x:offset.width,y:offset.height)
                .scaleEffect(scale * Double(1.0 / (Double(orbitsCount) / 3.0)))
            }
           
            .onAppear {
                if !generated{
                    self.generateRandomPositions(geoSize: size)
                }
            }
            .onChange(of: selectedAtomId) { newvalue in
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
            
            
            
            
            VStack(alignment:.leading, spacing:35){
                let selected = atoms[selectedAtomId]
                HStack{
                    Image(systemName: "info.bubble.fill")
                        .font(.system(size: 30))
                        .padding(.trailing,10)
                        .foregroundStyle(.secondary)
                    Text("\(selected.id)").bold().font(.system(size: 60))
                       .font(.system(size: 60))
                    let ion = protonsCount - electronCount
                     
                     Text(" \(ion > 0 ? "+" : "")\(ion)\n")
                            .font(.system(size: 30))
                            .baselineOffset(5.0)
                            .font(.system(size: 30))
                   
                       
                       
                    
                      
                }
                .contentShape(Rectangle())
                .baselineOffset(5.0) // Adjust the value to fine-tune the position
                .foregroundColor(.primary)
                .bold()
              
                .onTapGesture {
                    withAnimation(.bouncy){
                        if !self.showInfo{
                            self.showCustomization = false
                            self.showInfo = true
                        }else{
                            self.showInfo = false
                        }
                    }
                }
                HStack{
                    Button{
                        withAnimation(.easeInOut){
                            self.offset = .zero
                        }
                    }label:{
                        Image(systemName: "camera.metering.center.weighted")
                            .padding(20)
                            .background(Circle().fill(.regularMaterial))
                            .foregroundStyle(.primary)
                    }
                    .font(.system(size: 30))
                    Button{
                        
                        withAnimation(.easeInOut){
                            self.scale += 0.1
                        }
                    }label:{
                        Image(systemName: "plus.magnifyingglass")
                            .padding(20)
                            .background(Circle().fill(.regularMaterial))
                            .foregroundStyle(.primary)
                    }
                    .font(.system(size: 30))
                    Button{
                        withAnimation(.easeInOut){
                            self.scale -= 0.1
                        }
                    }label:{
                        Image(systemName: "minus.magnifyingglass")
                            .padding(20)
                            .background(Circle().fill(.regularMaterial))
                            .foregroundStyle(.primary)
                    }
                    .font(.system(size: 30))
                    
                }
               
            }
            .frame(maxWidth:.infinity,maxHeight:.infinity,alignment:.topLeading)
            if !showInfo{
                customization(size:size)
            }
                           
            if showInfo{
                let value = Swift.min (size.height, size.width)
                AtomInfoView(atom: atoms[selectedAtomId], geoSize: CGSize(width: value / 1.2, height: value / 2.5))
                    .offset(x:offsetForInfo)
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
                    .padding(25)
                    .transition(.move(edge: .trailing))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                if value.translation.width > 0{
                                    self.offsetForInfo = value.translation.width
                                }
                            })
                            .onEnded({ value in
                                if value.translation.width > 10{
                                    withAnimation(.bouncy(duration: 0.5)){
                                        
                                        self.showInfo = false
                                        self.offsetForInfo = 0
                                        
                                    }
                                }
                            })
                        
                    )
            }
        }
       
        .contentShape(Rectangle())
        .gesture(
                       DragGesture()
                           .onChanged { value in
                               let translation = value.translation
                               
                               self.offset = CGSize(width: translation.width + lastOffset.width, height:translation.height + lastOffset.height)
                           }
                           .onEnded({ value in
                               self.lastOffset = offset
                           })
                           .simultaneously(with:  MagnificationGesture()
                               .onChanged { value in
                                   let scaleChange = value - 1
                                   let newScale =  Swift.min(Swift.max(scaleChange + lastScale, 0.2), 3)
                                   
                                   
                                  
                                       self.scale = newScale
                               }
                                           
                               .onEnded({ value in
                                   
                                   self.lastScale = scale
                               })
                           )
                   )
        .preferredColorScheme(.dark)
        
        .padding(25)
        
        
        
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
   
}

#Preview {
    AtomModel_View()
}

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
struct Atom {
    let id: String
        let fullName: String
        let proton: Int
        let neutron: Int
        let electron: Int
        let max: Int
        let min: Int
        let group: Int // Add group property

    var mass: Int {
            return proton + neutron
        }
}

