//
//  ContentView.swift
//  WordScramble
//
//  Created by Brandon Knox on 3/5/21.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        List {
            ForEach(people, id: \.self) {
                Text($0)
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
