//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/25/24.
//

import SwiftUI


struct VesselSimulator: View {
    @State private var vesselWater = 90.0
    @State private var density = 1000.0
    @State private var gravity = 9.8
    @State private var showCustomize = true
    
    
    @State private var filling:Bool? = nil
    var body: some View {
        GeometryReader{geo in
            ZStack{
                CommunicatingVessel(water: $vesselWater,density: density)
                
                CustomizationView(show: $showCustomize, size: geo.size) {
                    customizeView
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width + 5)
    }
    var customizeView:some View{
        VStack(spacing:25){
            Picker("", selection: $density) {
                ForEach(Fluids.allCases,id:\.rawValue){fluid in
                    Text(fluid.rawValue.uppercased())
                        .tag(fluid.density)
                        
                }
            }
            .pickerStyle(.segmented)
            HStack{
                Text("Density").bold().font(.system(size: 20))
                Spacer()
                Text("\(density.formatted())").bold().font(.system(size: 20))
            }
            Divider()
            SliderWithText(value: $gravity, text: "Gravity", range: 3.7...24.9, step: 0.1,minValueText: "Mars",maxValueText: "Jupiter")
            if filling == nil{
                actionButtons
                    .padding(.top)
            }else{
                stopButton
            }
        }
        
       
    }
    var stopButton:some View{
        Button{
            withAnimation(.bouncy){
                self.filling = nil
            }
        }label: {
            ZStack{
                
                Circle()
                    .fill(Color.red)
                
                Text("Stop")
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                    .font(.system(size: 26))
                    
                
            }
            .frame(width: 100)
        }
    }
    var actionButtons:some View{
        HStack{
            Button{
                withAnimation(.bouncy){
                    self.filling = true
                }
            }label: {
                ZStack{
                    
                    Circle()
                        .fill(Color.accentColor)
                    
                    Text("Fill")
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                        .font(.system(size: 23))
                        
                    
                }
                .frame(width: 90)
            }
            Button{
                withAnimation(.bouncy){
                    self.filling = false
                }
            }label: {
                ZStack{
                    
                    Circle()
                        .fill(Color.accentColor)
                    
                    Text("Drain")
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                        .font(.system(size: 23))
                        
                    
                }
                .frame(width: 90)
            }
        }
       
    }
}

#Preview {
    VesselSimulator()
}

enum Fluids:String, CaseIterable{
    case gasoline,water,honey
    
    
    var density:Double{
        switch self {
        case .gasoline:
            return 700.0
        case .water:
            return 1000.0
        case .honey:
            return 1420.0
        }
    }
}
