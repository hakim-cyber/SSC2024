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
    @State private var protonsCount = 1
    @State private var neutron = 0
    @State private var electronCount = 1
    
    @State private var max = 1
    @State private var min = -1
    @State private var offsetForCustomization = 0.0
    @State private var showCustomization = false
    
    @State private var showProtonsNeutrons = true
    
    @State private var selectedAtomId:Int = 1
    
    @State private var showOrbits = true
    
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
                
                .contentShape(Circle())
                .scaleEffect(scale * Double(1.0 / (Double(orbitsCount) / 3.0)))
                .animation(.easeInOut, value: orbitsCount)
                .frame(maxWidth: .infinity,maxHeight:.infinity,alignment:.center)
                .offset(x:offset.width,y:offset.height)
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
            
            
            
            
            VStack{
                let selected = atoms[selectedAtomId]
                Text("\(selected.id)").bold().font(.system(size: 60))
                    .position(x:self.screen.width * 0.1)
                    .overlay (alignment:.topTrailing){
                       let ion = protonsCount - electronCount
                        
                        Text(" \(ion > 0 ? "+" : "")\(ion)\n")
                                .bold().font(.system(size: 30))
                                .position(x:self.screen.width * 0.14)
                          
                        
                        
                        
                    }
                    
                    .padding(.top,50)
                    
            }
           
           
                            ZStack{
                                if self.showCustomization{
                                    
                                    VStack(spacing: 20){
                                        HStack{
                                            Text("Atom")
                                                .bold()
                                                .font(.system(size: 20))
                                            Spacer()
                                            Picker("", selection: $selectedAtomId) {
                                                ForEach(atoms.indices,id:\.self) { atom in
                                                    let selected = atoms[atom]
                                                    Text(selected.id)
                                                        .tag(atom)
                                                        .bold()
                                                        
                                                }
                                            }
                                            .labelsHidden()
                                           
                                            
                                        }
                                        HStack{
                                            Text("Show Core")
                                            Spacer()
                                            Toggle("", isOn: $showProtonsNeutrons)
                                                .labelsHidden()
                                        }
                                        HStack{
                                            Text("Show Orbits")
                                            Spacer()
                                            Toggle("", isOn: $showOrbits)
                                                .labelsHidden()
                                        }
                                        VStack{
                                            Text("Electrons")
                                                .bold()
                                            
                                            HStack(spacing:15){
                                                Button("+"){
                                                    if self.protonsCount - self.electronCount > self.min{
                                                        self.electronCount += 1
                                                        print("+")
                                                    }
                                                }
                                                .buttonStyle(.borderedProminent)
                                                .font(.system(size: 24))
                                                .bold()
                                                Button("-"){
                                                    if self.protonsCount - self.electronCount < self.max{
                                                        self.electronCount -= 1
                                                        print("-")
                                                    }
                                                }
                                                .buttonStyle(.borderedProminent)
                                                .font(.system(size: 24))
                                                .bold()
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                                    .padding(30)
                                    .background{
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .fill(.regularMaterial)
                                        
                                    }
                                    .frame(width: size.width / 2.2 ,height: 250)
                                    .offset(x:offsetForCustomization)
                                    .transition(.move(edge: .trailing))
                                    .gesture(
                                        DragGesture()
                                            .onChanged({ value in
                                                if value.translation.width > 0{
                                                    self.offsetForCustomization = value.translation.width
                                                }
                                            })
                                            .onEnded({ value in
                                                if value.translation.width > 10{
                                                    withAnimation(.bouncy){
                                                        self.showCustomization = false
                                                    }
                                                }
                                            })
                                        
                                    )
                                }else{
                                    VStack{
                                        Button{
                                            withAnimation(.bouncy){
                                                self.showCustomization = true
                                                self.offsetForCustomization = 0
                                            }
                                           
                                        }label: {
                                            ZStack{
                                                RoundedRectangle(cornerRadius:10)
                                                    .fill(.regularMaterial)
                                                
                                                
                                                Image(systemName: "chevron.backward.2")
                                                    .bold()
                                            }
                                            .frame(width:50,height: 150)
                                        }
                                    }
                                    .transition(.push(from: .trailing))
                                    .frame(height: 250)
                                }
                                
                            }
                            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
                            .padding(25)
                           
                           
                       
        }
       
        .contentShape(Rectangle())
        .gesture(
                       DragGesture()
                           .onChanged { value in
                               let translation = value.translation
                               
                               self.offset = CGSize(width: translation.width, height:translation.height)
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
    let atoms:[Atom] = [Atom(id: "O", proton: 8, neutron: 8, electron: 8, max: 2, min: -2),Atom(id: "H", proton: 1, neutron: 0, electron: 1, max: 1, min: -1),Atom(id: "Al", proton: 13, neutron: 14, electron: 13, max: 3, min: 0),Atom(id: "Si", proton: 14, neutron: 14, electron: 14, max: 4, min: -4),Atom(id: "Ca", proton: 20, neutron: 20, electron: 20, max: 2, min: 0),Atom(id: "Ge", proton: 32, neutron: 41, electron: 32, max: 4, min: 0)
                        ,Atom(id: "Cu", proton: 29, neutron: 35, electron: 29, max: 4, min: 0),Atom(id: "Ag", proton: 47, neutron: 61, electron: 47, max: 3, min: 0),Atom(id: "Rh", proton: 45, neutron: 58, electron: 45, max: 6, min: -1)
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
                               width: Swift.min(geoSize.width / 6.0 / CGFloat((neutron + protonsCount)) * 3, geoSize.width / 23))
                        .offset(neutronPositions[id])
                    }
                    ForEach(0..<protonsCount, id: \.self) { id in
                        circle(string: "+",
                               color: .green,
                               width: Swift.min(geoSize.width / 6.0 / CGFloat((neutron + protonsCount)) * 3, geoSize.width / 23))
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
                CGSize(width: .random(in: -geoSize.width / 18 ... geoSize.width / 18), height: .random(in: -geoSize.width / 18 ... geoSize.width / 18))
            }

            protonPositions = (0..<protonsCount).map { _ in
                CGSize(width: .random(in: -geoSize.width / 18 ... geoSize.width / 18), height: .random(in: -geoSize.width / 18 ... geoSize.width / 18))
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

struct Atom:Identifiable{
    let id:String
    let proton:Int
    let neutron:Int
    let electron:Int
    let max:Int
    let min:Int
}
