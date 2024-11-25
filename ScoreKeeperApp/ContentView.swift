//
//  ContentView.swift
//  ScoreKeeperApp
//
//  Created by Yasseen Rouni on 6/20/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

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

struct OrientationModifier: ViewModifier {
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    
    func body(content: Content) -> some View {
        content
            .onAppear(perform: detectOrientation)
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                detectOrientation()
            }
    }
    
    private func detectOrientation() {
        let newOrientation = UIDevice.current.orientation
        if newOrientation.isPortrait || newOrientation.isLandscape {
            orientation = newOrientation
        }
    }
}

extension View {
    func detectOrientationChange() -> some View {
        self.modifier(OrientationModifier())
    }
}

struct ContentView: View {
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape
    
    var body: some View {
        LandscapeView()
    }
}

struct ColorOptions {
    let options: [(key: String, value: Image)] = [
        (key: "greenYellow", value: Image("greenYellow")),
        (key: "blueRed", value: Image("blueRed")),
        (key: "bluePink", value: Image("bluePink")),
        (key: "blueOrange", value: Image("blueOrange"))
    ]
}





struct SettingsView: View {
    
    
    let colorOptions = ColorOptions()
    @Binding var currentHomeColor: Color
    @Binding var currentAwayColor: Color
    @Binding var showingSettings: Bool
    @Binding var homeTeamName: String
    @Binding var awayTeamName: String
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            HStack {
                VStack {
                    Spacer()
                    HStack {
                            HStack {
                                Text("Change Color")
                                ForEach(colorOptions.options, id: \.key) { option in
                                    ZStack {
                                        Button {
                                            changeColor(currentHomeColor: currentHomeColor, currentAwayColor: currentAwayColor, key: option.key)
                                        } label: {
                                            option.value
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                    }
                                }
                            }
                        Spacer()
                        VStack {
                            Text("Change Team Name")
                            
                            TextField(text: $homeTeamName, prompt: Text("Home Team Name")){
                                Text("")
                            }
                        
                                .frame(width: 175)
                                .disableAutocorrection(true)
                                .textFieldStyle(.roundedBorder)
                                .border(.black)
                            TextField(text: $awayTeamName, prompt: Text("Away Team Name")){
                                Text("")
                            }
                                .frame(width: 175)
                                .disableAutocorrection(true)
                                .textFieldStyle(.roundedBorder)
                                .border(.black)
                            
                        }
                        Spacer()
                    }
                    Spacer()
                    Button {
                        self.showingSettings.toggle()
                    } label: {
                        Text("Exit")
                    }
                        .frame(width: 75, height: 25)
                        .padding(.vertical, 5)
                        .background(Color("Mikasa"))
                        .foregroundColor(.white)
                        .clipShape(.rect(cornerRadius:20))
                        .foregroundStyle(.white)
                        .accentColor(.white)
                    Spacer()
                }
                
                VStack {
                 
                }
                
                
            }
            
        }
    }
    
    func changeColor(currentHomeColor: Color, currentAwayColor: Color, key: String) {
        
        if (key == "blueRed") {
            self.currentHomeColor = .blue
            self.currentAwayColor = .red
        } else if (key == "bluePink"){
            self.currentHomeColor = Color(hex: "#0072b2")
            self.currentAwayColor = Color(hex: "cc79a7")
        } else if (key == "greenYellow"){
            self.currentHomeColor = Color(hex: "#009e73")
            self.currentAwayColor = Color(hex: "f0e442")
        } else if (key == "blueOrange"){
            self.currentHomeColor = Color(hex: "56b4e9")
            self.currentAwayColor = Color(hex: "d55e00")
        }
         
    
    }
    
}


struct LandscapeView: View {
    @State private var homeScore = 0
    @State private var awayScore = 0
    @State private var setScoreHome = 0
    @State private var setScoreAway = 0
    @State var showingSettings = false
    
    @State var homeColor: Color = Color(hex: "#009e73")
    @State var awayColor: Color = Color(hex: "f0e442")
    @State var homeTeamName = "Home"
    @State var awayTeamName = "Away"
    
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                ZStack {
                    VStack {
                        ZStack {
                            HStack {
                                Button {
                                    self.showingSettings.toggle()
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                }
                                .font(.system(size: 30))
                                .sheet(isPresented: $showingSettings) {
                                    SettingsView(currentHomeColor: $homeColor, currentAwayColor: $awayColor, showingSettings: $showingSettings, homeTeamName: $homeTeamName, awayTeamName: $awayTeamName)
                                }
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                Text(homeTeamName)
                                Spacer()
                                Spacer()
                                Text(awayTeamName)
                                Spacer()
                            }
                        }
                        
                        HStack{
                            Button {
                                homeScoreAdd()
                            } label : {
                                VStack {
                                    Text("\(homeScore)")
                                        .font(Font.custom("Exo 2", size: 96))
                                }
                                .frame(maxWidth: 360, maxHeight: 50)
                                .padding(.vertical, 100)
                                .background(Color(homeColor))
                                .clipShape(.rect(cornerRadius: 20))
                                .font(.system(size: 96))
                                .buttonStyle(PlainButtonStyle())
                                .foregroundColor(.black)
                            }
                            
                            Button {
                                awayScoreAdd()
                            } label : {
                                VStack {
                                    Text("\(awayScore)")
                                        .font(Font.custom("Exo 2", size: 96))
                                    
                                }
                                .frame(maxWidth: 360, maxHeight:50)
                                .padding(.vertical, 100)
                                .background(Color(awayColor))
                                .clipShape(.rect(cornerRadius: 20))
                                .font(.system(size: 96))
                                .buttonStyle(PlainButtonStyle())
                                .foregroundColor(.black)
                            }
                        }
                        HStack {
                            HStack {
                                MiscButton(buttonAction: {
                                    homeScoreSubtract()
                                }, buttonText: "-")
                                Button {
                                    homeScore = 0
                                } label: {
                                    Image(systemName: "arrow.uturn.backward.circle.fill")
                                }
                                .foregroundStyle(Color("Mikasa"))
                                .font(.system(size: 30))
                            }
                            
                            Spacer()
                            VStack {
                                Picker("Set Score", selection: $setScoreHome) {
                                    ForEach(0..<5, id:\.self) { score in
                                        Text("\(score)")
                                    }
                                }
                                .labelsHidden()
                                .frame(minWidth: 50, maxHeight: 25)
                                .padding(.vertical, 5)
                                .background(Color("Mikasa"))
                                .foregroundColor(.white)
                                .clipShape(.rect(cornerRadius:20))
                                .foregroundStyle(.white)
                                .accentColor(.white)
                            }
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
                                .frame(maxWidth: 90, maxHeight: 45)
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                            }
                            VStack {
                                Picker("Set Score", selection: $setScoreAway) {
                                    ForEach(0..<5, id:\.self) { score in
                                        Text("\(score)")
                                    }
                                }
                                .frame(minWidth: 50, maxHeight: 25)
                                .padding(.vertical, 5)
                                .background(Color("Mikasa"))
                                .foregroundColor(.white)
                                .clipShape(.rect(cornerRadius:20))
                                .foregroundStyle(.white)
                                .accentColor(.white)
                            }
                            Spacer()
                            
                            HStack {
                                
                                Button {
                                    awayScore = 0
                                } label: {
                                    Image(systemName: "arrow.uturn.backward.circle.fill")
                                }
                                .foregroundStyle(Color("Mikasa"))
                                .font(.system(size: 30))
                                MiscButton(buttonAction: {
                                    awayScoreSubtract()
                                }, buttonText: "-")
                                
                            }
                        }
                    }
                }
            }
        }
        .foregroundStyle(.black)
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
        setScoreHome = 0
        setScoreAway = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
            ContentView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}

#Preview {
    ContentView()
}
