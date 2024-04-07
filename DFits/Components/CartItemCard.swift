//
//  CartItemCard.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import Foundation
import SwiftUI

struct CartItemCard : View {
    //@EnvironmentObject var cartVM : CartViewModel
    //@State var getSize:Int = 1
    //@State var size:String = "S"
    
    var cartDM : CartDataModel
    var cartVM : CartViewModel
    
    var body: some View{
        HStack{
            let imageURL = URL(string: cartDM.prod_image)!
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
                Text(cartDM.prod_name)
                    .font(.system(size: 14, weight: .bold))
                Text("\(cartDM.prod_price, specifier: "%.2f") $")
                Text("Qty: \(cartDM.qty)")
            }
            .padding()
            Spacer()
            VStack{
                Circle()
                    .frame(width: 40)
                    .foregroundColor(Color.gray)
                    .overlay{
                        Text(cartDM.size)
                    }
            }
            .padding()
        }
        //.padding(.leading)
        .foregroundStyle(.black.opacity(0.8))
        .swipeActions(edge: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/,content: {
            Button(action: {
                withAnimation{
                    cartVM.deleteCartItem(ForItemID: "\(cartDM.id)")
                    cartVM.removeFromCart(item: cartDM)
                }
            }, label: {
                Text("Delete")
            }).tint(.red)
        })
        
    }
}

//#Preview {
//    CartItemCard(itemDM: sampleItemData[0])
//}
