//
//  SettingsView.swift
//  Kartai
//
//  Created by Sebastian Merkel on 17.01.24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    
    
    @Binding var color: Color
    @Binding var color2: Color
    @Binding var color3: Color
    @Binding var color4: Color
    
    @State var buttonPressed = UserDefaults.standard.bool(forKey: "buttonPressed")
    
    var colorData = ColorData()
    
    var body: some View {
        VStack {
            HStack {
                Text("Einstellungen")
                    .font(.system(size: 40))
                    .bold()
            }
            Divider()
            VStack {
                HStack {
                    ColorPicker("Kartenfarbe", selection: $color, supportsOpacity: false)
                        .onChange(of: color) { oldValue, newValue in
                            self.buttonPressed = false
                        }
                    }
                .font(.system(size: 20))
                .padding(.horizontal)
                HStack {
                    ColorPicker("Linienfarbe 1", selection: $color2, supportsOpacity: false)
                        .onChange(of: color2) { oldValue, newValue in
                            self.buttonPressed = false
                        }
                }
                .font(.system(size: 20))
                .padding(.horizontal)
                HStack {
                    ColorPicker("Linienfarbe 2", selection: $color3, supportsOpacity: false)
                        .onChange(of: color3) { oldValue, newValue in
                            self.buttonPressed = false
                        }
                }
                .font(.system(size: 20))
                .padding(.horizontal)
                HStack {
                    ColorPicker("Schriftfarbe", selection: $color4, supportsOpacity: false)
                        .onChange(of: color4) { oldValue, newValue in
                            self.buttonPressed = false
                        }
                }
                .font(.system(size: 20))
                .padding(.horizontal)
            }
            .frame(height: 170)
            .scrollDisabled(true)
            Divider()
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
                Text("Schrift")
                    .foregroundColor(color4)
                    .font(.system(size: 40))
                
            }
            Button(action: {
                colorData.saveData(color: color, color2: color2, color3: color3, color4: color4)
                buttonPressed.toggle()
                UserDefaults.standard.set(self.buttonPressed, forKey: "buttonPressed")
            }, label: {
                if buttonPressed == true {
                    Image(systemName: "checkmark.seal.fill")
                } else {
                    Image(systemName: "checkmark.seal")
                }
            })
            .disabled(buttonPressed)
            .font(.system(size: 50))
            .onAppear {
                self.buttonPressed = UserDefaults.standard.bool(forKey: "buttonPressed")
                if let loadedColors = colorData.loadData() {
                        self.color = loadedColors[0]
                        self.color2 = loadedColors[1]
                        self.color3 = loadedColors[2]
                        self.color4 = loadedColors[3]
                    } else {
                        // Handle error, e.g., use default values
                        self.color = Color.blue
                        self.color2 = Color.red
                        self.color3 = Color.white
                        self.color4 = Color.black
                    }
            }
        }
        Spacer()
    }
}
