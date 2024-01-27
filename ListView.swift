//
//  ListView.swift
//  Kartai
//
//  Created by Sebastian Merkel on 17.01.24.
//

import Foundation
import SwiftUI
import SwiftData

struct ListView: View {
    @Environment(\.modelContext) private var modelContext
    @State var isPresented = false
    var items: [Item]
    @State var begriff: String = ""
    @State var uebersetzung: String = ""
    
    var body: some View {
        Text("Datenbank")
            .font(.system(size: 40))
            .bold()
        HStack {
            Spacer()
            Button(action: {
                isPresented.toggle()
            }, label: {
                Image(systemName: "plus.app")
                    .font(.system(size: 40))
                    .padding(.horizontal)
            }).alert("Bitte Werte eingeben", isPresented: $isPresented) {
                VStack {
                    TextField("Begriff", text: $begriff)
                    TextField("Übersetzung", text: $uebersetzung)
                }
                HStack {
                    Button("Abbrechen") {
                        print("Abgebrochen")
                    }
                    Button("OK") {
                        if !(begriff.isEmpty) && !(uebersetzung.isEmpty) {
                            let neuesitem = Item(begriff: begriff, uebersetzung: uebersetzung)
                            
                            modelContext.insert(neuesitem)
                           
                            begriff = ""
                            uebersetzung = ""
                        } else {
                            begriff = ""
                            uebersetzung = ""
                        }
                    }
                }
            }
        }
        VStack {
            List() {
                ForEach(items) { item in
                    Text(item.begriff + " - " + item.uebersetzung)
                        .swipeActions {
                            Button("Löschen", role: .destructive) {
                                modelContext.delete(item)
                            }
                        }
                }
            }
        }
    }
}

