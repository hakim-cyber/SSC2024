//
//  AtomModel_View.swift
//  SSC24
//
//  Created by aplle on 12/17/23.
//

import SwiftUI

struct AtomModel_View: View {
     let protonsCount = 10
    let neutron = 5
    @State private var electronCount = 30
    
    @State private var max = 40
    @State private var min = -40
    @State private var offsetForCustomization = 0.0
    @State private var showCustomization = false
    var body: some View {
        GeometryReader{geo in
            ZStack{
                ZStack{
                    core(geoSize: geo.size)
                    let orbitsCount = numberOfOrbits(forElectrons: electronCount)
                    ForEach(1...orbitsCount,id:\.self){id in
                        orbits(geoSize: geo.size, id: CGFloat(id))
                    }
                }
                .ignoresSafeArea()
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
           
           
                            ZStack{
                                if self.showCustomization{
                                    
                                    VStack(spacing: 20){
                                        HStack{
                                            Text("Atom")
                                                .bold()
                                                .font(.system(size: 20))
                                            Spacer()
                                            Text("O")
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
                                    .frame(width: geo.size.width / 2.2 ,height: 250)
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
        .padding(25)
       
        
    }
    func circle(string:String,color:Color,width:CGFloat)->some View{
        ZStack{
            Circle()
                .fill(color)
                .overlay(alignment: .center) {
                    Text(string)
                        .padding(width / 7)
                        .bold()
                }
                .frame(width: width,height: width)
        }
    }
    func core(geoSize:CGSize)->some View{
        ZStack{
            
            ForEach(0..<neutron,id:\.self){id in
                circle(string: "", color: .yellow, width: Swift.min(geoSize.width / 6.0 / CGFloat((neutron + protonsCount) ) * 3, geoSize.width / 23) )
                    .offset(x:.random(in: -geoSize.width / 18 ... geoSize.width / 18),y:.random(in: -geoSize.width / 18 ... geoSize.width / 18))
                
            }
            ForEach(0..<protonsCount,id:\.self){id in
                circle(string: "+", color: .green, width:  Swift.min(geoSize.width / 6.0 / CGFloat((neutron + protonsCount) ) * 3, geoSize.width / 23) )
                    .offset(x:.random(in: -geoSize.width / 18 ... geoSize.width / 18),y:.random(in: -geoSize.width / 18 ... geoSize.width / 18))
                   
            }
            
        }
        .frame(width: geoSize.width / 6)
        
    }
    func orbits(geoSize:CGSize,id:CGFloat) -> some View{
        ZStack{
            Circle()
                .stroke(lineWidth: 1.0)
                
            // Electrons on the Orbit
            RadialLayout{
                let maxElectron = maxElectronCount(orbitId: Int(id))
              
                ForEach(0..<maxElectron, id: \.self) { electronIndex in
                    circle(string: "-", color: .red, width: 25)
                        
                }
                .padding(-10)
               
            }
          
                     
        }
        .frame(width: geoSize.width / 4 * (id) )
    }
    
    func maxElectronCount(orbitId:Int)->Int{
        let electronsAvailible = Swift.max(electronCount - electronsBefore(orbitId: orbitId), 0)
        return Swift.min(Swift.max(2 * orbitId * orbitId ,0), electronsAvailible )
    }
    func electronsBefore(orbitId:Int)->Int{
        var sum = 0
        
        for i in 1..<orbitId{
            sum += 2 * i*i
        }
        return sum
    }
    func numberOfOrbits(forElectrons electrons: Int) -> Int {
        let numberOfOrbits = Int(ceil(sqrt(Double(electrons) / 2)))
        return numberOfOrbits
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
