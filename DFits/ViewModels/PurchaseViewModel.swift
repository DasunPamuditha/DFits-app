//
//  PurchaseViewModel.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-31.
//

import Foundation

class PurchaseViewModel: ObservableObject {
    @Published var orders: [PurchaseDataModel] = []
    @Published var errorMessage: String = ""
    
//    init(){
//        fetchOrderData()
//    }
    
    func fetchOrderData(forEmail email: String) {
        guard let url = URL(string: "http://localhost:3000/api/orders/\(email)") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([PurchaseDataModel].self, from: data)
                DispatchQueue.main.async {
                    self.orders = decodedData
                }
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }.resume()
    }
}
