//
//  CartViewModel.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import Foundation
import SwiftUI

class CartViewModel : ObservableObject {
    @Published var errorMessage: String = ""
    @Published var items: [CartDataModel] = []
    @Published var total: Double = 0.00
    @Published var cartCount: Int = 0
    @Published var showError: Bool = false
    @Published var showSuccess: Bool = false
    @State var intValue: Int? = nil
    
    func fetchCartData(forEmail email: String) {
        guard let url = URL(string: "http://localhost:3000/api/cart/\(email)") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([CartDataModel].self, from: data)
                DispatchQueue.main.async {
                    self.items = decodedData
                    self.calculateTotal()
                }
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }.resume()
    }
    
    func deleteCartItem(ForItemID id: String) {
        guard let url = URL(string: "http://localhost:3000/api/cart/\(id)") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                return
            }
            DispatchQueue.main.async {
                // Handle successful deletion if needed
            }
        }.resume()
        
    }
    
    func removeFromCart(item : CartDataModel){
        items = items.filter { $0.id != item.id }
        calculateTotal()
    }
    
    private func calculateTotal() {
        var totalAmount: Double = 0.0
        for item in items {
            totalAmount += item.prod_price * Double(item.qty)
        }
        self.total = totalAmount
    }
    
    func placeOrder(email: String,total: String){
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let date = dateFormatter.string(from: currentDate)
        
        guard let url = URL(string: "http://localhost:3000/api/order") else {
            print("Invalid URL")
            return
        }
        let orderData = OrderDataModel(email: email, total: total, date: date)
        guard let jsonData = try? JSONEncoder().encode(orderData) else {
            self.showError = true
            self.errorMessage = "Failed to encode order data"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                self.showError = true
                self.errorMessage = "Error: \(error?.localizedDescription ?? "Unknown error")"
                self.errorMessage = "something went wrong"
                return
            }
            
            if httpResponse.statusCode == 200 {
                self.showSuccess = true
                
            }
        }.resume()
    }
    
    func placeOrderItem(order_id: Int,item_id: Int,size: String, qty: Int){
        guard let url = URL(string: "http://localhost:3000/api/order/add-items") else {
            print("Invalid URL")
            return
        }
        let orderData = OrderItemDataModel(order_id: order_id, item_id: Int(item_id), size: size, qty: qty)
        guard let jsonData = try? JSONEncoder().encode(orderData) else {
            self.showError = true
            self.errorMessage = "Failed to encode order data"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                self.showError = true
                self.errorMessage = "Error: \(error?.localizedDescription ?? "Unknown error")"
                self.errorMessage = "something went wrong"
                return
            }
            
            if httpResponse.statusCode == 200 {
                self.showSuccess = true
                
            }
        }.resume()
    }
    
    func deleteCartItems(forEmail email: String) {
        guard let url = URL(string: "http://localhost:3000/api/cart/delete/\(email)") else {
            self.showError = true
            self.errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                self.showError = true
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                self.showSuccess = true
            } else {
                self.showError = true
                self.errorMessage = "Error deleting cart items"
            }
        }.resume()
    }
    
}
