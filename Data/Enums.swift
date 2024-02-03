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
                🔍 Fluid Equilibrium:
                The Communicating Vessels Physics Theorem unveils the principles governing fluid equilibrium in interconnected containers. It provides insights into the behavior of liquids when communicating vessels are connected, offering a foundation for understanding fluid dynamics.

                ⚖️ Balancing Act: Equating Heights
                At its core, the theorem states that in communicating vessels, connected at the bottom and filled with an incompressible fluid, the heights of the fluid columns are equal. This fundamental concept highlights the equilibrium achieved in the system as the fluid seeks a consistent level across connected containers.

                🌊 Fluid Dynamics: Grasping Interconnected Flows
                Exploring the theorem delves into the fascinating world of fluid dynamics. As fluid moves between vessels, principles of pressure, continuity, and conservation of energy come into play, shaping the dynamic equilibrium observed in the interconnected system.

                🚰 Practical Applications: Beyond the Lab
                The Communicating Vessels Physics Theorem finds applications in various real-world scenarios. Understanding fluid equilibrium is crucial in fields such as hydraulics, plumbing, and even the design of water distribution systems. The theorem serves as a cornerstone for engineers and scientists dealing with fluid-related phenomena.

                ⚙️ Engineering Insights: Designing with Fluids in Mind
                Engineers leverage the theorem's principles when designing systems involving interconnected vessels. Whether it's designing fountains, hydraulic systems, or plumbing networks, the theorem guides the creation of structures that maintain fluid balance, ensuring optimal performance.

                📈 Mathematics of Fluids: Calculating Equilibrium
                Mathematical equations derived from the theorem enable precise calculations of fluid levels in communicating vessels. These equations offer a quantitative understanding of fluid behavior, facilitating predictions and optimizing system designs.

                🔬 Experimental Validation: Hands-On Understanding
                Laboratory experiments validating the Communicating Vessels Physics Theorem provide students and researchers with hands-on insights. Witnessing fluid equilibrium in action enhances the understanding of theoretical concepts and reinforces the theorem's practical relevance.

                🌐 Interdisciplinary Impact: Fluid Dynamics Across Disciplines
                Beyond physics, the theorem's principles extend into interdisciplinary domains. From civil engineering to environmental science, the interconnected nature of fluids plays a crucial role, making the theorem a key component in diverse fields.

                🌊 In Conclusion: Navigating Fluid Equilibrium
                The Communicating Vessels Physics Theorem navigates the intricate world of fluid equilibrium, offering a fundamental understanding of how liquids behave in interconnected systems. Its applications in engineering, mathematics, and beyond underscore its significance in unraveling the mysteries of fluid dynamics.
                """
        case .pyfagore:
    """
   
🔍 The Geometric Foundation:
The Pythagorean Theorem stands as a cornerstone in geometry, unveiling profound relationships within right-angled triangles. At its core, it asserts that the square of the hypotenuse's length equals the sum of the squares of the other two sides.

⚡ A² + B² = C²: The Formula Unveiled
Expressed as the iconic equation A² + B² = C², the theorem provides a powerful tool to calculate unknown side lengths. 'A' and 'B' symbolize the triangle's legs, while 'C' represents the hypotenuse, showcasing the elegant relationship between these geometric elements.

🕰️ Historical Roots: Pythagoras' Legacy
Named after the ancient Greek mathematician Pythagoras, this theorem traces its origins to the 6th century BCE. Pythagoras and his followers recognized its universality and significance, transcending cultural and historical boundaries.

🌐 Beyond Triangles: Applications in Diverse Fields
While initially devised for triangles, the Pythagorean Theorem has found unexpected applications across various disciplines. From navigation and architecture to physics and computer graphics, its versatility underscores its timeless relevance.

🔍 Geometric Insight: Visualizing the Theorem's Proof
Visual proofs of the Pythagorean Theorem abound, offering unique insights into its validity. Whether through rearrangement of squares or geometric constructions, these visual demonstrations provide an intuitive understanding of the theorem's fundamental principles.

📊 Pythagorean Triplets: Numerical Patterns Unveiled
Exploring the Pythagorean Theorem reveals fascinating numerical patterns known as Pythagorean triplets. These sets of integers (a, b, c) satisfying the theorem have captivated mathematicians for centuries, adding an extra layer of intrigue to this geometric gem.

💻 Modern Applications: Theorem in Action
In the contemporary world, the Pythagorean Theorem is not merely a historical relic but a practical tool. It underpins technologies such as GPS, ensuring accurate distance calculations and playing a pivotal role in fields where spatial relationships matter.

📚 Educational Pillar: Teaching Mathematical Concepts
Beyond its applications, the Pythagorean Theorem serves as a foundational concept in mathematics education. Its elegance and simplicity make it a starting point for learners, fostering a deeper appreciation for the interconnectedness of mathematical principles.

🌐 In Conclusion: A Geometric Odyssey
The Pythagorean Theorem transcends its humble origins, emerging as a timeless piece of mathematical brilliance. Its impact, both historically and in contemporary applications, showcases the enduring power of fundamental geometric principles.
"""
        case .atomModel:
            
"""
🔍 Atom: The Fundamental Building Block
At the heart of matter lies the atom, the smallest unit of an element. It consists of a nucleus, composed of positively charged protons and uncharged neutrons, surrounded by negatively charged electrons in orbit.

⚡ Electrons: Energetic Participants
Electrons, with a negative charge, orbit the nucleus in distinct energy levels or shells. They are vital in chemical reactions, determining an element's behavior, and are involved in the formation of compounds.

🧲 Protons: Nucleus Inhabitants
Protons, positively charged particles, reside in the nucleus. The number of protons defines an element's identity, contributing to its atomic number.

🔗 Neutrons: The Neutral Balancers
Neutrons, electrically neutral, accompany protons in the nucleus, providing stability and influencing the atom's mass without affecting its charge.

🔄 Electron Orbits: Defined Pathways
Electrons follow specific orbits or energy levels around the nucleus. Understanding these orbits helps predict an element's reactivity and chemical bonding patterns.

➖ Minus Ions: Electron Loss
When an atom gains extra electrons, it becomes a negative ion (anion). This negatively charged ion is crucial in various chemical processes.

➕ Plus Ions: Electron Gain
Conversely, when an atom loses electrons, it becomes a positive ion (cation). Positive ions play a significant role in ionic bonding and conductivity.

🌐 Real-World Applications: Why Atomic Structure Matters
Understanding atomic structure is essential for numerous real-world applications:

Chemistry: Guides chemical reactions, bonding, and the creation of new materials.
Medicine: Aids in understanding biological processes, drug development, and medical imaging.
Technology: Enables advancements in electronics, nanotechnology, and materials science.
Energy: Forms the basis for understanding nuclear reactions and harnessing energy.
In essence, delving into the intricacies of atoms provides a foundation for technological innovation, medical breakthroughs, and a deeper comprehension of the natural world, fostering progress and discovery in various fields.
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
