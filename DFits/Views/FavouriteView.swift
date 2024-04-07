//
//  FavouriteView.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import SwiftUI

struct FavouriteView: View {
    
    @StateObject var userVM : UserViewModel = UserViewModel()
    //@State var favVM : FavouriteViewModel = FavouriteViewModel()
    @ObservedObject var favVM = FavouriteViewModel()
    
    var body: some View {
        
        List{
            if userVM.authenticated {
                if favVM.items.isEmpty {
                    Text("Favourites are Empty!")
                }else {
                    ForEach(favVM.items){
                        data in
                        FavouriteItemCard(itemDM: data, favVM: favVM, userVM: userVM)
                    }
                }
            } else {
                Text("Login to check your Favouries!")
            }
        }
        .onAppear{
            if userVM.authenticated{
                favVM.fetchFavouriteItems(forEmail: userVM.username)
            }
        }
        .onSubmit {
            if userVM.authenticated{
                favVM.fetchFavouriteItems(forEmail: userVM.username)
            }
        }
    }
}

#Preview {
    FavouriteView()
}
