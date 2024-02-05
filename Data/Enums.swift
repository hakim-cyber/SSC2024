//
//  Enums.swift
//  SSC24
//
//  Created by aplle on 12/17/23.
//


import SwiftUI

enum Subjects:String,CaseIterable,Hashable{
    case math,physics,  chemistry ,informatics
}
extension Subjects{
    var icon:Image{
        switch self {
        case .math:
            return Image(systemName: "x.squareroot")
        case .physics:
            return Image(systemName: "bolt")
        case .chemistry:
            return Image(systemName: "atom")
        case .informatics:
            return Image(systemName: "laptopcomputer")
        }
    }
    var color:Color{
        switch self {
        case .math:
            return Color.blue
        case .physics:
            return Color.green
        case .chemistry:
            return Color.red
        case .informatics:
            return Color.purple
        }
    }
}



enum AboutInfo :String, Identifiable,CaseIterable{
    var id: String{
        return self.rawValue
    }
 case atomModel , communicatingVessels,pyfagore
    
    var content: some View{
        ImageView(info: self)
    }
    var inventor:String{
        switch self {
        case .atomModel:
            "John Dalton"
        case .communicatingVessels:
            "Simon Stevin"
        case .pyfagore:
            "Pythagoras of Samos"
        }
    }
    var cardImage:Image{
        switch self {
        case .pyfagore:
            Image("pythagoreStart")
        case .atomModel:
            Image("atomStart")
        case .communicatingVessels:
            Image("vesselsStart")
        }
    }
    var header:String{
        switch self {
        case .pyfagore:
            "Pythagorean Theorem"
        case .atomModel:
         "Atomic Model"
        case .communicatingVessels:
            "Communicating Vessels"
        }
    }
    var color:Color{
        switch self {
        case .pyfagore:
            return Color.blue
        case .communicatingVessels:
            return Color.green
        case .atomModel:
            return Color.red
        
        }
    }
    var aboutText:String{
        switch self {
        case .communicatingVessels:
                """
                The Principle of Communicating Vessels in Everyday Life 🚿🌊

                Introduction:
                Ever wondered why it's so easy to spill water from a teapot or watering can? 🤔 Let's dive into the science behind the fascinating principle of communicating vessels and explore its everyday applications. 🌐💧

                The Principle of Communicating Vessels:
                The magic lies in the hydrostatic pressure within connecting pipes. Each point in a vessel experiences pressure due to the weight of the water above it. This pressure, determined solely by depth, ensures water levels in communicating vessels align horizontally. 🔄📏

                Everyday Applications:

                Spilling from Teapots and Watering Cans:

                Tipping them causes water levels to stay in sync, making spills easy with a slight tilt. 🚰🌊
                Level Indicators in Containers:

                Gadgets like kettle level indicators use this principle to accurately represent liquid levels inside. 🍵📏
                Hose Scales:

                Hose scales use communicating vessels to measure if two points are at the same height. 📐🚿
                Locks:

                Water locks employ connecting channels to maintain water levels, facilitating smooth vessel navigation. ⛵🌊
                Artesian Wells and DIY Experiment:

                Artesian Wells:

                Nature's example of communicating vessels - water under pressure rises when drilled into impermeable rocks. 💦🏞️
                DIY Artesian Well Experiment:

                Recreate the effect using a funnel and thin water hose. The water will spurt out, showcasing the connected vessels principle. 🚰🌀💡
                """
        case .pyfagore:
    """
The Pythagorean theorem is like a math superhero that's been around forever. Named after Pythagoras, a math hero from ancient Greece, this idea is way cooler than you might think. Let's dive into its story!

History:
Picture this – around 6th century BCE in ancient Greece, Pythagoras, a math genius, might have discovered this math gem. But guess what? Clever folks from other places, like Babylon and Egypt, might've known it too, way before.

The Theorem:
Imagine a right-angled triangle. The longest side (we call it the hypotenuse) squared equals the sum of the other two sides squared. In simple terms: c² = a² + b².

Why it's Awesome:

Building Cool Stuff 🏰:

Architects and builders use it to make sure buildings and structures are strong and steady, especially when there are right angles involved.
Angles and Distances 🎯:

It helps us figure out angles and distances. Imagine you're playing a game of catch – knowing the distance helps you throw accurately.
Making Cool Stuff 🎮:

Ever seen computer games or drawings in 3D? The Pythagorean theorem plays a role in creating those cool graphics.
Everyday Math 🧮:

Even though it sounds fancy, it's just a helpful tool in everyday math problems. Like if you want to know how far your TV is from your couch!
The Pythagorean theorem might be an old math idea, but it's still super useful today. Whether you're building something, playing a game, or just figuring out distances, this little formula is your math buddy. 🌟🔢📏
"""
        case .atomModel:
            
"""
Ever wondered about the tiny building blocks that make up everything around us? Enter John Dalton, an English chemist and physicist, who transformed ancient Greek atomic philosophy into a scientific theory between 1803 and 1808. Let's explore why his atomic model became a game-changer!

Dalton's Atomic Model: The Basics 📚🔬:
In his book "A New System of Chemical Philosophy," Dalton introduced the following ideas:

Tiny Particles Called Atoms 🧊:

Everything, he said, is made up of super tiny particles called atoms. They're like the LEGO pieces of the universe.
Indestructible and Stubborn Atoms 🛡️🔨:

Dalton believed that atoms are indestructible and resist any changes. They can't be broken down into smaller bits or magically transformed into atoms of something else.
Conservation of Mass Matters ⚖️:

Dalton was all about the law of conservation of mass – the idea that matter doesn't magically appear or disappear. Atoms stay the same, just rearrange themselves.
Identical Atoms in Elements 🌍🔄:

According to Dalton, all atoms of an element are like identical twins – same shape, same size, and same mass.
Whole-Number Ratios and Chemical Reactions 🤝🧪:

When atoms get together for chemical parties, they do it in small whole-number ratios to create what we now call molecules.
Different Molecules, Same Atoms 🔄🌈:

Dalton suggested that different molecules could form from the same types of atoms but in different ratios. Think of it like making different recipes with the same set of ingredients.
Why Dalton's Model Mattered 💡:
Dalton's atomic model was a big deal because it explained the laws of conservation of mass, definite proportions, and multiple proportions. It gave scientists a clear picture of how elements combined to form compounds, unlocking the secrets of the tiny world around us. 🤯🔍

In a Nutshell:
Thanks to Dalton, we now see the world as a collection of unbreakable LEGO-like atoms, each playing its part in the grand chemistry of life. It's a simple yet powerful concept that laid the foundation for understanding the complexities of matter. ⚛️🌌🔍
"""
            
            
        }
    }
    
}

struct ImageView:View {
    
    let info:AboutInfo
   
    var body: some View {
        switch info {
        case .pyfagore:
            PythagoreanAboutAnimation()
        case .atomModel:
            AtomModelAboutAnimation()
        case .communicatingVessels:
            Image("vessels").resizable()
        }
    }
        
}
