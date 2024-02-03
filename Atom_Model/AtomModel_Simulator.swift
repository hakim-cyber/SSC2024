//
//  AtomModel_View.swift
//  SSC24
//
//  Created by aplle on 12/17/23.
//

import SwiftUI
import TipKit

struct AtomModel_Simulator: View {
  
    @State private var generated = false
   
    @State  var electronCount = 1
    
    
    @State  var offsetForInfo = 0.0
    @State  var showCustomization = false
    
    @State  var showInfo = false
    
    @State  var showProtonsNeutrons = true
    
    @State  var selectedAtomId:Int = 1
    
    @State  var showOrbits = true
   
    @State private var scale = 0.5
    @State private var lastScale = 0.5
    
    @State private var offset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    
    var atom:Atom{
        atoms[selectedAtomId]
    }
    var body: some View {
        GeometryReader{geo in
            let size = geo.size
            ZStack{
                AtomModel(size: size, showOrbits: self.showOrbits, showProtonsNeutrons: showProtonsNeutrons, scale: scale, offset: offset, selectedAtomId: selectedAtomId,electronCount: $electronCount)
                
                
                VStack(alignment:.leading, spacing:35){
                    let selected = atoms[selectedAtomId]
                    HStack{
                        
                        Text("\(selected.id)").bold().font(.system(size: 60))
                            .font(.system(size: 60))
                        let ion = atom.proton - self.electronCount
                        
                        Text(" \(ion > 0 ? "+" : "")\(ion)\n")
                            .font(.system(size: 30))
                            .baselineOffset(5.0)
                            .font(.system(size: 30))
                        
                        
                        
                        
                        
                    }
                    .contentShape(Rectangle())
                    .baselineOffset(5.0) // Adjust the value to fine-tune the position
                    .foregroundColor(.primary)
                    .bold()
                    .padding(15)
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
                    VStack{
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
                .padding(15)
                
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
            .inspector(isPresented: $showCustomization){
                customization()
                    .inspectorColumnWidth(min:250,ideal: geo.size.width / 3 ,max:400)
               
                    
            }
            .toolbar{
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        withAnimation(.bouncy){
                            if !self.showInfo{
                                self.showCustomization = false
                                self.showInfo = true
                            }else{
                                
                                self.showInfo = false
                            }
                        }                }label: {
                        Image(systemName: "info.bubble")
                               
                                
                    }
                       
                       
                       
                }
               
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        withAnimation(.bouncy){
                            self.showInfo  = false
                            self.showCustomization.toggle()
                        }
                    }label: {
                        Image(systemName: "slider.horizontal.3")
                           
                    }
                    .popoverTip(StartTip(text: "Open Customize"))
                }
               
                
            }
          
           
            .navigationTitle(AboutInfo.atomModel.header)
            .navigationBarTitleDisplayMode(.inline)
            
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

#Preview {
    AtomModel_Simulator()
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


struct StartTip:Tip{
    let text:String
   
    var title: Text{
        Text(text)
            .bold()
        
    }
   
    

}
