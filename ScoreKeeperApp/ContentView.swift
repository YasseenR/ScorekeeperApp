//
//  ContentView.swift
//  ScoreKeeperApp
//
//  Created by Yasseen Rouni on 6/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var homeScore = 0
    @State private var awayScore = 0
    
    
    var body: some View {
        ZStack {
            Color("Mikasa")
                .ignoresSafeArea()
            VStack (spacing: 30) {
                Spacer()
                Text("Score")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                HStack (spacing: 0) {
                    ZStack {
                        Color.blue
                        VStack {
                            Text("Home")
                            Spacer()
                            Button {
                                homeScoreAdd()
                            } label : {
                                VStack {
                                    Text("\(homeScore)")
                                    
                                }
                                .frame(maxWidth: 180)
                                    .padding(.vertical, 60)
                                .background(.regularMaterial)
                                .clipShape(.rect(cornerRadius: 20))
                                .font(.system(size: 64))
                                .buttonStyle(PlainButtonStyle())
                            }
                            
                            Spacer()
                            
                        }
                    }
                    .foregroundStyle(.black)
                    ZStack {
                        Color.red
                        VStack {
                            Text("Away")
                            Spacer()
                            Button {
                                awayScoreAdd()
                            } label : {
                                VStack {
                                    Text("\(awayScore)")
                                    
                                }
                                .frame(maxWidth: 180)
                                    .padding(.vertical, 60)
                                .background(.regularMaterial)
                                .clipShape(.rect(cornerRadius: 20))
                                .font(.system(size: 64))
                            }
                            Spacer()
                        }
                        
                    }
                    .foregroundStyle(.black)
                }
                ZStack {
                    Color("Mikasa")
                    VStack {
                        Button {
                            scoreReset()
                        } label : {
                            ZStack {
                                Color(.white)
                                VStack {
                                    Text("Reset")
                                    
                                }
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
    
    func awayScoreAdd() {
        
        awayScore += 1
    }
    
    func scoreReset() {
        awayScore = 0
        homeScore = 0
    }
}

#Preview {
    ContentView()
}
