//
//  ContentView.swift
//  Kartai
//
//  Created by Sebastian Merkel on 30.12.23.
//

import SwiftUI
import SwiftData

let itemDummy = Item(begriff: "Begriff", uebersetzung: "Übersetzung")

@Model
class Item {
    
    var id: UUID
    var begriff: String
    var uebersetzung: String
    
    init(begriff: String, uebersetzung: String) {
        self.id = UUID()
        self.begriff = begriff
        self.uebersetzung = uebersetzung
    }
}

class ColorData {
    private var COLOR_KEY_1 = "COLOR_KEY_1"
    private var COLOR_KEY_2 = "COLOR_KEY_2"
    private var COLOR_KEY_3 = "COLOR_KEY_3"
    private var COLOR_KEY_4 = "COLOR_KEY_4"
    private let userDefaults = UserDefaults.standard
    
    func saveData(color: Color, color2: Color, color3: Color, color4: Color) {
        let color = UIColor(color).cgColor
        let color2 = UIColor(color2).cgColor
        let color3 = UIColor(color3).cgColor
        let color4 = UIColor(color4).cgColor
        
        if let components = color.components {
            userDefaults.set(components, forKey: COLOR_KEY_1)
        }
        if let components2 = color2.components {
            userDefaults.set(components2, forKey: COLOR_KEY_2)
        }
        if let components3 = color3.components {
            userDefaults.set(components3, forKey: COLOR_KEY_3)
        }
        if let components4 = color4.components {
            userDefaults.set(components4, forKey: COLOR_KEY_4)
        }
        
    }
    
    func loadData() -> [Color]? {
        guard let array = userDefaults.object(forKey: COLOR_KEY_1) as? [CGFloat] else { return nil }
        guard let array2 = userDefaults.object(forKey: COLOR_KEY_2) as? [CGFloat] else { return nil }
        guard let array3 = userDefaults.object(forKey: COLOR_KEY_3) as? [CGFloat] else { return nil }
        guard let array4 = userDefaults.object(forKey: COLOR_KEY_4) as? [CGFloat] else { return nil }
        
        let color = Color(.sRGB, red: array[0], green: array[1], blue: array[2])
        let color2 = Color(.sRGB, red: array2[0], green: array2[1], blue: array2[2])
        let color3 = Color(.sRGB, red: array3[0], green: array3[1], blue: array3[2])
        let color4 = Color(.sRGB, red: array4[0], green: array4[1], blue: array4[2])
        
        return [color, color2, color3, color4]
        
    }
}

struct ContentView: View {
    @State var backDegree = 90.0
    @State var frontDegree = 0.0
    @State var isFlipped = false
    let durationAndDelay = 0.3
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State var index = 0
    @State var color: Color = Color.blue
    @State var color2: Color = Color.red
    @State var color3: Color = Color.white
    @State var color4: Color = Color.black
    
    let colorData = ColorData()
    
    func flipCard() {
        isFlipped = !isFlipped
        
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                backDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0
            }
        }
    }
    
    func nextItem() {
        if items.count > 0 {
            if index < items.count - 1 {
                index += 1
            } else {
                index = 0
            }
        } else {
            return
        }
    }
    
    func backItem() {
        
        if items.count > 0 {
            
            if index <= items.count - 1 {
                
                index -= 1
                
            }
            
            if index < 0 {
                
                index = items.count - 1
                
            }
            
        } else {
            return
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Kartai")
                    .font(.system(size: 40))
                    .bold()
                HStack {
                    NavigationLink(destination: SettingsView(color: $color, color2: $color2, color3: $color3, color4: $color4)) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 40))
                            .padding(.horizontal)
                    }
                    Spacer()
                    NavigationLink(destination: ListView(items: items)) {
                        Image(systemName: "plus.app")
                            .font(.system(size: 40))
                            .padding(.horizontal)
                    }
                }
                Spacer()
                
                if items.count > 0 {
                    
                    ZStack {
                        CardFront(degree: $frontDegree, color: $color, color2: $color2, color3: $color3, color4: $color4, item: items[index])
                        CardBack(degree: $backDegree, color: $color, color2: $color2, color3: $color3, color4: $color4, item: items[index])
                            .onAppear {
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
                    .onTapGesture {
                        flipCard()
                    }
                    
                } else {
                    
                    ZStack {
                        CardFront(degree: $frontDegree, color: $color, color2: $color2, color3: $color3, color4: $color4, item: itemDummy)
                        CardBack(degree: $backDegree, color: $color, color2: $color2, color3: $color3, color4: $color4, item: itemDummy)
                    }.onTapGesture {
                        flipCard()
                    }
                }
                HStack {
                    Button(action: {
                        backItem()
                    }, label: {
                        Image(systemName: "arrow.backward.square")
                            .font(.system(size: 80))
                    })
                    .frame(width: 150)
                    Button(action: {
                        nextItem()
                    }, label: {
                        Image(systemName: "arrow.right.square")
                            .font(.system(size: 80))
                    })
                    .frame(width: 150)
                }
                .padding(50)
                
                Spacer()
            } .onAppear {
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
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
