//
//  SwiftUIView.swift
//  
//
//  Created by aplle on 1/25/24.
//

import SwiftUI


struct VesselSimulator: View {
    @State private var vesselWater = 25.0//minimum 10
    @State private var density = 1000.0
    @State private var gravity = 9.8
    @State private var showCustomize = true
    
    @State private var showAtmopshere = true
    
    
    @State private var filling:Bool? = nil
    
    @State private var fillTimer: Timer?
    
    
    @State private var selectedVessel = Vessels.vessel2
    
    var pressure:CGFloat{
        let height = (vesselWater - 20) * 3 / 80
        let pressure = height * density * gravity  + (showAtmopshere ? 101325 : 0)
        return pressure
    }
    var body: some View {
        GeometryReader{geo in
            ZStack{
                if showAtmopshere{
                    Color(red: 0.579, green: 0.898, blue: 0.972).ignoresSafeArea()
                }
                CommunicatingVessel(water: $vesselWater,density: density,selected: selectedVessel)
                   
                       
                CustomizationView(show: $showCustomize, size: geo.size) {
                    customizeView
                }
                VStack(spacing: 15){
                    ForEach(Vessels.allCases,id:\.rawValue){vessel in
                        let selected = vessel.rawValue == selectedVessel.rawValue
                        RoundedRectangle(cornerRadius: 15 )
                            .stroke(Color.black,lineWidth:8)
                            .frame(width: 70,height:70)
                            
                            .overlay{
                                Text("\(vessel.rawValue + 1)")
                                    .bold()
                                    .font(.system(size: 23))
                                    .foregroundStyle(.black)
                            }
                            .opacity(selected ? 1.0 : 0.5)
                            .onTapGesture{
                                if !selected{
                                   
                                        self.selectedVessel = vessel
                                    
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity,maxHeight:.infinity, alignment: .leading)
                .padding(25)
                .padding(.bottom,60)
            }
            .animation(.easeInOut, value: showAtmopshere)
            .onAppear {
                       startFillingTimer()
                
                   }
                   .onDisappear {
                       fillTimer?.invalidate()
                   }
           
        
        }
        .frame(width: UIScreen.main.bounds.width + 5)
    }
    private func startFillingTimer() {
        fillTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if let filling = filling {
                withAnimation(.bouncy){
                    if filling {
                        
                        if vesselWater < 100{
                            vesselWater += 5
                        }else{
                            self.filling = nil
                        }
                        
                        
                        // Adjust the rate at which water is added
                    } else {
                        
                        if vesselWater > 20{
                            vesselWater -= 5
                        }else{
                            self.filling = nil
                        }
                        
                        // Adjust the rate at which water is drained
                    }
                }
            }
        }
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
                Text("\(density.formatted())").bold().font(.system(size: 18))
                   
            }
           
           
            
            SliderWithText(value: $gravity, text: "Gravity", range: 3.7...24.9, step: 0.1,minValueText: "Mars",maxValueText: "Jupiter")
                .contentShape(Rectangle())
            HStack{
                Text("Atmosphere").bold().font(.system(size: 20))
                
                Spacer()
                Toggle("", isOn: $showAtmopshere)
                   
            }
            Rectangle()
                .frame(height: 1)
                
            HStack{
                Text("Pressure").fontWeight(.heavy).font(.system(size: 23))
                
                Spacer()
                Text("\(pressure.formatted())").fontWeight(.heavy).font(.system(size: 23))
                    .foregroundStyle(Color.accentColor)
                    .contentTransition(.numericText())
            }
            if filling == nil{
                actionButtons
                    .padding(.top)
            }else{
                stopButton
                    .padding(.top)
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

enum Vessels:Int,CaseIterable{
    case vessel1,vessel2
    
    var vessel:any Shape{
        switch self {
        case .vessel1:
            Vessel1()
        case .vessel2:
            Vessel2()
        }
    }
    var grass:any Shape{
        switch self {
        case .vessel1:
            Vessel1Grass()
        case .vessel2:
            Vessel2Grass()
        }
    }
}
