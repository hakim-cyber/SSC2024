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



enum AboutInfo {
 case pyfagore, atomModel
    
    var content: some View{
        ImageView(info: self)
    }
    var header:String{
        switch self {
        case .pyfagore:
            "Pythagorean Insight"
        case .atomModel:
         "Decoding the Atom"
        }
    }
    var aboutText:String{
        switch self {
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
            PythagoreanAbout()
        case .atomModel:
            Image("electron").resizable()
        }
    }
        
}
