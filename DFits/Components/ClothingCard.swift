//
//  ClothingCard.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import Foundation
import SwiftUI

struct ClothingCard : View {
    @EnvironmentObject var cartVM : CartViewModel
    
    @State private var refresh = false
    @State private var showAlert = false
    
    
    var itemDM: ItemDataModel
    var favVM : FavouriteViewModel
    var userVM : UserViewModel
    
    var body: some View{
        NavigationLink(destination: ItemDetailView(itemDM: itemDM,userID: userVM.username)){
            ZStack(alignment: .topTrailing){
                ZStack(alignment: .bottom){
                    //image fetch using url
                    let imageURL = URL(string: itemDM.prod_image)!
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView() // Placeholder while loading
                                .cornerRadius(10)
                                .cornerRadius(10)
                                .frame(width: 160,height: 190)
                        case .success(let image):
                            image
                                .resizable()
                                .cornerRadius(10)
                                .cornerRadius(10)
                                .frame(width: 160,height: 190)
                        case .failure(let error):
                            Text("Failed to load image")
                                .foregroundColor(.red)
                                .padding()
                                .frame(width: 160,height: 190)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 1)
                                )
                                .onTapGesture {
                                    print("Error loading image: \(error.localizedDescription)")
                                }
                        default:
                            //EmptyView()
                            Image("sampleMen")
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: 160,height: 190)
                                .scaledToFit()
                        }
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text(itemDM.prod_name)
                                .font(.system(size: 14, weight: .bold))
                            
                            Text("$ \(itemDM.prod_price, specifier: "%.2f")")
                                .font(.caption)
                                .font(.system(size: 10))
                        }
                        Spacer()
                        Button{
                            if userVM.authenticated{
                                favVM.addToFavourites(item_id: "\(itemDM.id)", user_id: userVM.username)
                            } else {
                                //show alert
                                showAlert = true
                            }
                        } label: {
                            Image(systemName: "heart.fill")
                                .imageScale(.large)
                                .foregroundColor(.red)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Unable to Add to Favourites"),
                                message: Text("Make sure to login before add Favourites")
                            )
                        }
                        
                    }
                    .padding()
                    .frame(width: 160, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
                .shadow(radius: 9)
            }
            
        }
    }
}

//
//#Preview{
//    ClothingCard(itemDM : sampleItemData[0])
//}
