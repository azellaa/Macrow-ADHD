//
//  Cobacoba.swift
//  Macrow-ADHD
//
//  Created by Jessica Rachel on 31/10/23.
//
import SwiftUI

struct LevelButton: View {
    let level: Int
    @Binding var selectedLevel: Int
    
    var body: some View {
        Button(action: {
            selectedLevel = level
        }) {
            Text("Level \(level)")
                .padding()
                .background(selectedLevel == level ? Color.blue : (level <= 3 && selectedLevel >= level ? Color.green : Color.gray))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disabled(level > 3 && selectedLevel < level)
    }
}

struct Cobacoba: View {
    @State private var selectedLevel: Int = 1
    
    var body: some View {
        VStack {
            Text("Selected Level: \(selectedLevel)")
                .font(.title)
            
            HStack {
                ForEach(1...5, id: \.self) { level in
                    LevelButton(level: level, selectedLevel: $selectedLevel)
                }
            }
        }
    }
}



#Preview {
    Cobacoba()
}
