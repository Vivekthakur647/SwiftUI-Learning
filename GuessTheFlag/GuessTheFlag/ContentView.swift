//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by VIVEK THAKUR on 11/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var yourScore = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
   @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack {
//            Color.blue.ignoresSafeArea()
            
//            LinearGradient(gradient: Gradient.init(colors: [.blue , .black]), startPoint: .leading, endPoint: .trailing).ignoresSafeArea()
            
//            RadialGradient(stops: [
//                .init(color: .blue, location: 0.3),
//                .init(color: .red, location: 0.3),
//            ], center: .top, startRadius: 200, endRadius: 700)
//                .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack (spacing : 15){
                    VStack {
                        Text("Tap the flag of").foregroundStyle(.primary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).foregroundColor(.white).font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            // flag was tapped
                            flagTapped(number)
                        } label: {
                            Image(countries[number].lowercased())
                                .renderingMode(.original).clipShape(Capsule())
                                .shadow(radius: 6)
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score:  \(yourScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Aks Quetion", action: askQuestion)
        } message: {
            Text("Your score is \(yourScore)")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            yourScore = yourScore + 10
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
