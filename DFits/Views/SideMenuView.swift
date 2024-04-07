//
//  SideMenuView.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-31.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @State private var isShowingUserView = false // State to control the display of UserView
    
    var body: some View {
        VStack(alignment: .leading) {
            // User profile button
            Button(action: {
                isShowingUserView = true // Toggle the state to show UserView
            }) {
                HStack {
                    Image(systemName: "person.fill")
                    Text("User")
                }
            }
            .padding()
            .sheet(isPresented: $isShowingUserView) { // Present UserView as a sheet
                UserView()
            }

            // Notifications button
            Button(action: {
                // Perform notifications actions
            }) {
                HStack {
                    Image(systemName: "bell.fill")
                    Text("Notifications")
                }
            }
            .padding()
            
            Spacer()
        }
        .frame(width: 250)
        .background(Color.gray.opacity(0.5))
        .offset(x: isShowing ? 0 : -250)
        .transition(.move(edge: .leading))
    }
}
