//
//  TimerView.swift
//  Aesthetic Pomodoro
//
//  Created by Brian Seo on 2023-04-28.
//

import SwiftUI
import UserNotifications

let width: CGFloat = 200.0
let height: CGFloat = 90.0

struct Initial {
    struct Work {
        static let minutes = 20
        static let seconds = 0
    }
    
    struct Break {
        static let minutes = 5
        static let seconds = 0
    }
}

struct SessionView: View {
    @State var title: String
    @State var minuteRemaining = Initial.Work.minutes
    @State var secondRemaining = Initial.Work.seconds
    @State var round = 0
    
    @State var showResetConfirmatinoView = false
    @State var play: Bool = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var isBreakRound = false
    
    var body: some View {
        VStack {
            Text(title)
                .frame(width: width, height: height / 3.0)
                .background {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.gray)
                }
                        
            VStack {
                HStack {
                    Button {
                        showResetConfirmatinoView.toggle()
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                    .alert("Are you sure you want to reset the timer", isPresented: $showResetConfirmatinoView) {
                        Button("NO", role: .cancel) {   }
                        Button("YES", role: .destructive) {
                            resetTimer()
                        }
                        
                    }

                    Text(isBreakRound ?
                         "Break" : "Work")
                        .bold()
                        .padding()
                    
                    Text("\(round)")
                        .background {
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(.brown)
                        }
                }
                Image(systemName: play ? "livephoto.play": "pause.circle")
                Text("\(minuteRemaining) : \(String(format: "%.2d", secondRemaining))")
                    .padding()
            }
                .frame(width: width, height: height)
                .background {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.pink)
                }
                .onReceive(timer) { _ in
                    tickTimer()
                }
        }
        .onTapGesture {
            play.toggle()
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func tickTimer() {
        if play {
            if secondRemaining > 0 {
                secondRemaining -= 1
            } else if secondRemaining == 0 {
                if minuteRemaining > 0 {
                    minuteRemaining -= 1
                    secondRemaining = 59
                } else {
                    finishRound()
                }
            }
        }
    }
    
    private func finishRound() {
        
        let content = UNMutableNotificationContent()
        content.title = isBreakRound ? "BREAK" : "WORK" + " ROUND IS OVER"
        content.subtitle = isBreakRound ? "TIME TO GET BACK TO WORK" : "WELL DONE"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
        
        isBreakRound.toggle()
        if isBreakRound {
            minuteRemaining = Initial.Break.minutes
            secondRemaining = Initial.Break.seconds
        } else {
            minuteRemaining = Initial.Work.minutes
            secondRemaining = Initial.Work.seconds
        }
    }
    
    private func resetTimer() {
        minuteRemaining = 20
        secondRemaining = 0
        round = 0
    }
}


struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(title: "👨🏻‍💻 iOS Development")
    }
}
