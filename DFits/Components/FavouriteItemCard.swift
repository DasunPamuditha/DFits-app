//
//  FavouriteItemCard.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-28.
//

import Foundation
import SwiftUI

struct FavouriteItemCard : View {
    
    var itemDM : ItemDataModel
    var favVM : FavouriteViewModel
    var userVM : UserViewModel
    
    var body: some View{
        HStack{
            let imageURL = URL(string: itemDM.prod_image)!
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView() // Placeholder while loading
                        .cornerRadius(10)
                        .cornerRadius(10)
                        .frame(width: 100,height: 100)
                        .aspectRatio(contentMode: .fit)
                case .success(let image):
                    image
                        .resizable()
                        .cornerRadius(10)
                        .cornerRadius(10)
                        .frame(width: 100,height: 100)
                        .aspectRatio(contentMode: .fit)
                case .failure(let error):
                    Text("Failed to load image")
                        .foregroundColor(.red)
                        .padding()
                        .frame(width: 100,height: 100)
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
                        .frame(width: 100,height: 100)
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                }
            }
            VStack{
                Text(itemDM.prod_name)
                Text("\(itemDM.prod_price, specifier: "%.2f") $")
            }.padding()
        }
        .padding(.horizontal,2)
        .foregroundStyle(.black.opacity(0.8))
        .swipeActions(edge: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/,content: {
            Button(action: {
                withAnimation{
                    favVM.deleteFavouriteItem(ForItemID: "\(itemDM.id)")
                    favVM.removeFromFavourite(item: itemDM)
                }
            }, label: {
                Text("Remove")
            }).tint(.red)
        })
        
    }
}
