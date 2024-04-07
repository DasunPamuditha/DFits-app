//
//  CartButton.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import Foundation
import SwiftUI

struct CartButton : View{
    var numberOfProducts: Int
    //@StateObject var cartBtnVM: CartButtonViewModel = CartButtonViewModel()
     
    var body: some View{
        
        ZStack(alignment: .topTrailing){
            Image(systemName: "cart")
                .padding(.top, 5)
            
            if(numberOfProducts > 0){
                Text("\(numberOfProducts)")
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .background(.red)
                    .cornerRadius(50)
            }
        }
    }
}

struct CartButton_Previews : PreviewProvider {
    static var previews: some View{
        CartButton(numberOfProducts: 1)
    }
}
