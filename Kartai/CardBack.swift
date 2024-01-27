//
//  CardBack.swift
//  Kartai
//
//  Created by Sebastian Merkel on 17.01.24.
//

import Foundation
import SwiftUI
import SwiftData

struct CardBack: View {
    @Binding var degree: Double
    @Binding var color: Color
    @Binding var color2: Color
    @Binding var color3: Color
    @Binding var color4: Color
    var item: Item
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(color)
                .frame(width: 320, height: 220)
                .padding()
                .overlay(
                    ZStack {
                        
                        Path { path in
                            path.move(to: CGPoint(x: 17, y: 60))
                            path.addLine(to: CGPoint(x: 335, y: 60))
                        }.stroke(color2.opacity(0.4))
                        
                        Path { path in
                            path.move(to: CGPoint(x: 17, y: 80))
                            path.addLine(to: CGPoint(x: 335, y: 80))
                        }.stroke(color3.opacity(0.4))
                        
                        Path { path in
                            path.move(to: CGPoint(x: 17, y: 100))
                            path.addLine(to: CGPoint(x: 335, y: 100))
                        }.stroke(color3.opacity(0.4))
                        
                        Path { path in
                            path.move(to: CGPoint(x: 17, y: 120))
                            path.addLine(to: CGPoint(x: 335, y: 120))
                        }.stroke(color3.opacity(0.4))
                        
                        Path { path in
                            path.move(to: CGPoint(x: 17, y: 140))
                            path.addLine(to: CGPoint(x: 335, y: 140))
                        }.stroke(color3.opacity(0.4))
                        
                        Path { path in
                            path.move(to: CGPoint(x: 17, y: 160))
                            path.addLine(to: CGPoint(x: 335, y: 160))
                        }.stroke(color3.opacity(0.4))
                        
                        Path { path in
                            path.move(to: CGPoint(x: 17, y: 180))
                            path.addLine(to: CGPoint(x: 335, y: 180))
                        }.stroke(color3.opacity(0.4))
                        
                        Path { path in
                            path.move(to: CGPoint(x: 17, y: 200))
                            path.addLine(to: CGPoint(x: 335, y: 200))
                        }.stroke(color3.opacity(0.4))
                    }
                )
            Text(item.uebersetzung)
                .foregroundColor(color4)
                .font(.system(size: 40))
        }.rotation3DEffect(Angle(degrees: degree),axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}


