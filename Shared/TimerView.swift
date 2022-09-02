//
//  TimerView.swift
//  Executive Timer
//
//  Created by 常志平 on 31/8/22.
//

import Foundation
import SwiftUI

let defaultTime: CGFloat = 60

struct TimerView: View {
    @State private var timerRunning = false
    @State private var countdownTime: CGFloat = defaultTime
    @State private var countdownColor = Color.green
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let strokeStyle = StrokeStyle(lineWidth: 15, lineCap: .round)
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), style: strokeStyle)
            Circle()
                .trim(from: 0, to: 1 - (defaultTime - countdownTime) / defaultTime)       // trim the shape by a fractional amount, based on its representation as a path.
                .stroke(countdownColor, style: strokeStyle)                               // .stroke sets the color of the outline of the shape
                .rotationEffect(.degrees(-90))                     // .rotationEffect rotates the element by the specified amount, begin at 12 o'clock point, 0 is at the 15 minutes point.
                .animation(.easeInOut(duration: 0.2), value: countdownTime)               // .animation sets the speed at which any animation takes place in the view.
            HStack(spacing: 70) {
                Label("", systemImage: timerRunning ? "pause.rectangle.fill": "play.rectangle.fill")    // icon click to start
                    .foregroundColor(.green).font(.title)
                    .onTapGesture(perform: { timerRunning.toggle() })
                Text("\(Int(countdownTime))")                                                          // the init time of timer
                Label("", systemImage: "gobackward.60")                                                // icon of the restart
                    .foregroundColor(.red)
                    .font(.title)
                    .onTapGesture(perform: {
                        timerRunning = false
                        countdownTime = defaultTime    // When the third label with the reset icon, is tapped, the timerRunning Boolean is set to false, and the countdownTime is set back to the defaultTime
                    })
            }
        }.frame(width: 300, height: 300)               // We've framed the ZStack to a nice 300*300 square,
            
            /* .onReceive is an instance method available on views that lets you specify a publisher to respond to, and a method to run when that publisher emits data.
             The perform parameter specifies the method to be run when the specified publisher (in this case, timer) emit something.
             */
            .onReceive(timer, perform: {_ in
                guard timerRunning else { return }
                if countdownTime > 0 {
                    countdownTime -= 1
                    countdownColor = {
                        switch (countdownTime) {
                            case 30...: return Color.green
                            case 15...: return Color.yellow
                            default: return Color.red
                        }}()
                } else {
                    timerRunning = false
                    countdownTime = defaultTime
                    countdownColor = Color.green
                }
            })
    }
}
