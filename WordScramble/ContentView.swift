//
//  ContentView.swift
//  WordScramble
//
//  Created by Brandon Knox on 3/5/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        let input = """
                    a
                    b
                    c
                    """
        let letters = input.components(separatedBy: "\n")
        let letter = letters.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        return Text("Hello World")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
