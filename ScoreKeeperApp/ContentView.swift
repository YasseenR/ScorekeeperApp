//
//  ContentView.swift
//  ScoreKeeperApp
//
//  Created by Yasseen Rouni on 6/20/24.
//

import SwiftUI

struct MiscButton: View {
    
    var buttonAction: () -> Void
    var buttonText: String
    
    var body: some View {
        Button (action: buttonAction) {
            Text(buttonText)
                .frame(minWidth: 50)
                .padding(.vertical, 5)
                .background(Color("Mikasa"))
                .foregroundColor(.white)
                .clipShape(.rect(cornerRadius:20))
            
        }
        
    }
    
    
}

struct ContentView: View {
    @State private var homeScore = 0
    @State private var awayScore = 0
    
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            VStack (spacing: 30) {
                Spacer()
                Text("Score")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.black)
                HStack (spacing: 0) {
                    ZStack {
                        Color(.white)
                        VStack {
                            Spacer()
                            Text("Home")
                                .foregroundStyle(.black)
                                .font(.system(size: 24))
                            Spacer()
                            Button {
                                homeScoreAdd()
                            } label : {
                                VStack {
                                    Text("\(homeScore)")
                                    
                                }
                                .frame(maxWidth: 180)
                                .padding(.vertical, 120)
                                .background(.blue)
                                .clipShape(.rect(cornerRadius: 20))
                                .font(.system(size: 96))
                                .buttonStyle(PlainButtonStyle())
                                
                            }
                            HStack (spacing: 75){
                                
                                MiscButton(buttonAction: {
                                    homeScoreSubtract()
                                }, buttonText: "-")
                                
                                MiscButton(buttonAction: {// action here
                                }, buttonText: "1")
                                
                            }
                            
                            Spacer()
                            Spacer()
                            
                        }
                    }
                    .foregroundStyle(.black)
                    ZStack {
                        Color(.white)
                        VStack {
                            Spacer()
                            Text("Away")
                                .foregroundStyle(.black)
                                .font(.system(size: 24))
                            Spacer()
                            Button {
                                awayScoreAdd()
                            } label : {
                                VStack {
                                    Text("\(awayScore)")
                                    
                                }
                                .frame(maxWidth: 180)
                                    .padding(.vertical, 120)
                                .background(.red)
                                .clipShape(.rect(cornerRadius: 20))
                                .font(.system(size: 96))
                            }
                            HStack (spacing: 75){
                                
                                
                                MiscButton(buttonAction: {// action here
                                }, buttonText: "0")
                                
                                MiscButton(buttonAction: {
                                    awayScoreSubtract()
                                }, buttonText: "-")
                                
                                
                                
                            }
                            Spacer()
                            Spacer()
                        }
                        
                        
                    }
                    .foregroundStyle(.black)
                }
                ZStack {
                    Color(.white)
                    VStack {
                        Button {
                            scoreReset()
                        } label : {
                            ZStack {
                                Color("Mikasa")
                                VStack {
                                    Text("Reset All")
                                    
                                }
                                .foregroundColor(.white)
                            }
                            .frame(maxWidth: 180, maxHeight: 90)
                            .clipShape(.capsule)
                            .shadow(radius: 5)                        }
                        
                    }
                    
                }
                .foregroundStyle(.green)
            }
        }
    }
    func homeScoreAdd() {
        
        homeScore += 1
        
    }
    
    func homeScoreSubtract() {
        
        if (homeScore > 0) {
            homeScore -= 1
        }

    }
    
    func awayScoreAdd() {
        
        awayScore += 1
    }
    
    func awayScoreSubtract() {
        if (awayScore > 0) {
            awayScore -= 1
        }
    }
    
    func scoreReset() {
        awayScore = 0
        homeScore = 0
    }
}

#Preview {
    ContentView()
}
