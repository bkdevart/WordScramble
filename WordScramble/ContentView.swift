//
//  ContentView.swift
//  WordScramble
//
//  Created by Brandon Knox on 3/5/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var totalScore = 0
//    @State private var color = Color(red: 0.0, green: 0.0, blue: 0.0)
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                // For a real challenge make the letter count images in project 5 change color as you scroll. For the best effect, you should create colors using the Color(red:green:blue:) initializer, feeding in values for whichever of red, green, and blue you want to modify. The values to input can be figured out using the row’s current position divided by maximum position, which should give you values in the range 0 to 1.
                GeometryReader { fullView in
                    List(usedWords, id: \.self) { word in
                        GeometryReader { geo in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                    .foregroundColor(Color(red: Double((CGFloat.random(in: 0.0...1.0) * (fullView.size.height / geo.frame(in:                              .global).maxY))),
                                                           green: Double((CGFloat.random(in: 0.0...1.0) * (fullView.size.height / geo.frame(in:                              .global).maxY))),
                                                           blue: Double((CGFloat.random(in: 0.0...1.0) * (fullView.size.height / geo.frame(in:                              .global).maxY)))))
                                Text(word)
                            }
                            .offset(x: pow(2, CGFloat(geo.frame(in: .global).minY) - fullView.size.height))
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(word), \(word.count) letters"))
                        }
                    }
                }
                Text("Score: \(totalScore)")
                    .font(.largeTitle)
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .toolbar {
                Button("New Word") {
                    startGame()
                }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        guard isSameWord(word: answer) else {
            wordError(title: "Invalid word", message: "Cannot use the same word as given or one that is less than three letters")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
        totalScore = getScore(words: usedWords)
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try?
                String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func isSameWord(word: String) -> Bool {
        if isReal(word: word) && word != rootWord {
            return true
        } else {
            return false
        }
    }
    
    func getScore(words: [String]) -> Int {
        // get count of total words?
        let wordCount = words.count
        var letterCount = 0
        print(wordCount)
        for word in words {
            letterCount += word.count
        }
        
        return letterCount
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
