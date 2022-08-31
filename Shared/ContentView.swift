//
//  ContentView.swift
//  Shared
//
//  Created by 常志平 on 30/8/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TimerView()
                .padding()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
                .tag("Timer")
            TimerSettingView()
                .padding()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
                .tag("Setting have no code")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
