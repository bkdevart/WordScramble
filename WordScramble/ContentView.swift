//
//  ContentView.swift
//  WordScramble
//
//  Created by Brandon Knox on 3/5/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        let input = "a b c"
        let letters = input.components(separatedBy: " ")
        
        return Text("Hello World")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
