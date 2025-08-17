//
//  SplashScreenView.swift
//  Veather
//
//  Created by Vedant Patle on 16/08/25.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack{
            Color.blue.opacity(0.5)
                .ignoresSafeArea()
            VStack{
                Image("Icon")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("Weather Update")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
