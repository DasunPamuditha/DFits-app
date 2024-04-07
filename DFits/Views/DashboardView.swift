//
//  DashboardView.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack{
            TabView{
                HomeView()
                    .tabItem {
                        Label("Home",systemImage: "house")
                    }
                FavouriteView()
                    .tabItem {
                        Label("Favourites",systemImage: "heart")
                    }
                PurchaseView()
                    .tabItem {
                        Label("Orders",systemImage: "list.clipboard")
                    }
                UserView()
                    .tabItem {
                        Label("Me",systemImage: "person")
                    }
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashboardView()
}
