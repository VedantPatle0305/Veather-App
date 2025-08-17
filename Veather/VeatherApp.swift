//
//  VeatherApp.swift
//  Veather
//
//  Created by Vedant Patle on 16/08/25.
//

import SwiftUI

@main
struct VeatherApp: App {
    @State private var showSplashScreen = true
    
    var body: some Scene {
        WindowGroup {
            if showSplashScreen {
                SplashScreenView()
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            self.showSplashScreen = false
                        }
                    }
            }
            else{
                ContentView()
            }
        }
    }
}
