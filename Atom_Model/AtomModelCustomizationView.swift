//
//  File.swift
//  
//
//  Created by aplle on 1/23/24.
//

import SwiftUI


extension AtomModel_Simulator{
    func customization() -> some View{
        CustomizationView(show: $showCustomization) {
            VStack(spacing: 25){
                HStack{
                    Text("Atom")
                        .bold()
                        .font(.system(size:  25)) // Set an initial font size
                        .minimumScaleFactor(0.5)
                    Spacer()
                    Picker("", selection: $selectedAtomId) {
                        ForEach(atoms.indices,id:\.self) { atom in
                            let selected = atoms[atom]
                            Text(selected.id)
                                .tag(atom)
                               
                                .bold()
                                .font(.system(size:  25)) // Set an initial font size
                                .minimumScaleFactor(0.5)
                        }
                    }
                    .labelsHidden()
                   
                   
                    
                }
                HStack{
                    Text("Show Core")
                        .bold()
                        .font(.system(size:  25)) // Set an initial font size
                        .minimumScaleFactor(0.5)
                    Spacer()
                    Toggle("", isOn: $showProtonsNeutrons)
                        .labelsHidden()
                }
                HStack{
                    Text("Show Orbits")
                        .bold()
                        .font(.system(size:  25)) // Set an initial font size
                        .minimumScaleFactor(0.5)
                    Spacer()
                    Toggle("", isOn: $showOrbits)
                        .labelsHidden()
                }
                VStack{
                    Text("Electrons")
                        .bold()
                        
                    
                    HStack(spacing:15){
                        Button{
                            if atom.proton - self.electronCount > atom.min{
                                self.electronCount += 1
                                print("+")
                            }
                        }label: {
                            Text("+")
                            .padding(5)
                        }
                        .buttonStyle(.borderedProminent)
                        .font(.system(size:30))
                        .bold()
                        Button{
                            if atom.proton - self.electronCount < atom.max{
                                self.electronCount -= 1
                                print("-")
                            }
                        }label: {
                            Text("-")
                            .padding(3)
                            .padding(.horizontal,4)
                        }
                       
                        .buttonStyle(.borderedProminent)
                        .font(.system(size: 35))
                        .bold()
                    }
                }
            }
        }
    }
}
