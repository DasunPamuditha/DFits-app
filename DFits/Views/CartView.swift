//
//  CartView.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import SwiftUI

struct CartView: View {
    //@EnvironmentObject var cartVM : CartViewModel
    @StateObject var userVM : UserViewModel = UserViewModel()
    @ObservedObject var cartVM = CartViewModel()
    @State var total : Double = 0.00
    @State var orderID : Int = 0
    @State var updateCart: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                Spacer()
                VStack(spacing: 20){
                    Text("Cart").bold()
                        .font(.title)
                    
                    //Spacer()
                    VStack{
                        List{
                            if userVM.authenticated {
                                if cartVM.items.isEmpty {
                                    Text("Your cart is Empty, add some now!")
                                }else {
                                    ForEach(cartVM.items){
                                        data in
                                        CartItemCard(cartDM: data, cartVM: cartVM)
                                    }
                                }
                            } else {
                                Text("Login to check your Cart!")
                            }
                        }
                        
                    .onAppear{
                            if userVM.authenticated{
                                cartVM.fetchCartData(forEmail: userVM.username)
                            }
                        }
                        .onSubmit {
                            if userVM.authenticated{
                                cartVM.fetchCartData(forEmail: userVM.username)
                            }
                        }
                        .frame(width: 370,height: 500)
                        
                    }
                    Spacer()
                    
                    VStack{
                        Spacer()
                        HStack{
                            Text("Total")
                            Spacer()
                            Text("$ \(cartVM.total, specifier: "%.2f")")
                        }
                        HStack{
                            Text("Discount")
                            Spacer()
                            Text("$ 0.00")
                        }
                        Spacer()
                        //1 Spacer()
                        HStack{
                            Text("Amount")
                            Spacer()
                            Text("$ \(cartVM.total, specifier: "%.2f")")
                        }
                        //Text(cartVM.latestOrderId)
                    }.padding(.horizontal,20)
                    
                    Button{
                        cartVM.placeOrder(email: userVM.username, total: "\(cartVM.total)")
                        cartVM.deleteCartItems(forEmail: userVM.username)
                        for data in cartVM.items {
                            cartVM.placeOrderItem(order_id: 0, item_id: data.id, size: data.size, qty: data.qty)
                            cartVM.removeFromCart(item: data)
                        }
                    } label: {
                        HStack{
                            Text("CHECKOUT")
                                .foregroundStyle(.white).bold()
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32,height:48)
                    }
                    .background(Color(.systemBlue))
                    .cornerRadius(50)
                    .alert(isPresented: $cartVM.showError) {
                        Alert(
                            title: Text("Unable to Place the Order"),
                            message: Text("Please try again later")
                        )
                    }
                    .alert(isPresented: $cartVM.showSuccess) {
                        Alert(
                            title: Text("Your Order"),
                            message: Text("Order Placed Successfully")
                        )
                    }
                    
                    Spacer()
                }
                .padding(.top)
                .padding(.bottom)
                .preferredColorScheme(.light)
                Spacer()
            }
        }
//        .onTapGesture {
//            if userVM.authenticated{
//                cartVM.fetchCartData(forEmail: userVM.username)
//            }
//        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartViewModel())
}
