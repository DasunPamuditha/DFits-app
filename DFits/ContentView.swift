//
//  ContentView.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        NavigationStack
        {
            ZStack {
                Color.color
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.3)
                    .foregroundColor(.white.opacity(0.6))
                
                VStack{
                    Text("D'Fits!")
                        .font(.largeTitle)
                        .bold()
                        .padding(10)
                    NavigationLink("Click Here", destination: DashboardView())
                }
                .padding()
            }
        }
    }
}
    #Preview {
        ContentView()
    }

