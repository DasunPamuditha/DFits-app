//
//  PurchaseView.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-31.
//

import SwiftUI

struct PurchaseView: View {
    @StateObject var ordersVM = PurchaseViewModel()
    @StateObject var userVM = UserViewModel()
    @State var total: Double = 0.00
    
    var body: some View {
        ZStack{
            NavigationView{
                VStack(spacing: 20){
                    Text("Your Purchases")
                        .bold()
                    
                    List{
                        ForEach(ordersVM.orders){
                            order in
                            //Text(ordersVM.errorMessage)
                            Section("Order No: \(order.id)"){
                                
                                VStack(alignment: .leading,spacing: 4){
                                    if let tot = Double(order.total){
                                        Text("Total Bill: \(tot, specifier: "%.2f")")
                                    }
                                    Text("Order Date: \(order.order_date)")
                                }
                            }
                        }
                    }
                    .onAppear{
                        ordersVM.fetchOrderData(forEmail: userVM.username)
                    }
                    .padding()
                    .preferredColorScheme(.light)
                    .frame(alignment: .bottom)
                    
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    PurchaseView()
}
