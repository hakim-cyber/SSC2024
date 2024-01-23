//
//  File.swift
//  
//
//  Created by aplle on 1/7/24.
//

import SwiftUI

struct CustomizationView<Content:View>:View {
    @Binding var show:Bool
    let size:CGSize
    @ViewBuilder var content:Content
    
    @State  var offsetForCustomization = 0.0
    var body: some View {
        ZStack{
            if self.show{
                content
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                .padding(30)
                .background{
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.regularMaterial)
                    
                }
                .frame(width:   Swift.min (size.height, size.width) / 1.5 ,height:  Swift.min (size.height, size.width) / 3.1)
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
                                    self.show = false
                                }
                            }
                        })
                    
                )
                
            }else{
                VStack{
                    Button{
                        withAnimation(.bouncy){
                            self.show = true
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
}



extension AtomModel_View{
    func customization(size:CGSize) -> some View{
        CustomizationView(show: $showCustomization, size: size) {
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
        }
    }
}


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
