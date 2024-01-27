//
//  AtomModelOrbit.swift
//  SSC24
//
//  Created by aplle on 1/6/24.
//

import SwiftUI

struct AtomModelOrbit: View {
    let geoSize:CGSize
    let id:CGFloat
    let electronCount:Int
    let show:Bool
    
    @State private var rotation = 0.0
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth:5.0)
                .opacity(show ? 1 : 0)
            // Electrons on the Orbit
            RadialLayout{
                let maxElectron = Swift.max(maxElectronCount(orbitId: Int(id)),0)
              
                ForEach(0..<maxElectron, id: \.self) { electronIndex in
                    circle(string: "-", color: .red, width: 25)
                        
                }
                .padding(-10)
               
            }
          
                     
        }
        .rotationEffect(.degrees(rotation))
        .onAppear {
                withAnimation(.linear(duration: CGFloat (id * 5 ))
                                .repeatForever(autoreverses: false)) {
                                    self.rotation = 360.0
                        }
                    }
      
        .frame(width: (min(geoSize.width,geoSize.height) / 3.5) * id )
       
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
}

#Preview {
    AtomModelOrbit(geoSize: .zero, id: 0, electronCount: 3, show: true)
}
