//
//  ItemViewModel.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//


import Foundation
import SwiftUI

class ItemViewModel : ObservableObject {
    //@Published var itemData = sampleItemData
    @Published var categoryData = sampleCategoryData
    @Published var searchString : String = ""
    @Published var searchCategory : String = "All"
    
    @Published var itemDM = [ItemDataModel]()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "http://localhost:3000/api/items") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode([ItemDataModel].self, from: data) {
                DispatchQueue.main.async {
                    self.itemDM = decodedResponse
                }
            }
        }.resume()
    }
    enum SortOrder {
        case none, lowToHigh, highToLow
    }
    
    func sortItems(by order: SortOrder) {
        switch order {
        case .lowToHigh:
            itemDM.sort { $0.prod_price < $1.prod_price }
        case .highToLow:
            itemDM.sort { $0.prod_price > $1.prod_price }
        case .none:
            // No sorting or reset to original order if needed
            break
        }
    } 
    
    func fetchData(category: String,searchString: String) {
        var dataURL = "http://localhost:3000/api/items"
        
        if searchString.isEmpty{
            dataURL = "http://localhost:3000/api/items/\(category)"
        } else {
            if category == "All" {
                dataURL = "http://localhost:3000/api/items/search/\(searchString)"
            } else {
                dataURL = "http://localhost:3000/api/items/\(category)/search/\(searchString)"
            }
        }
        
        guard let url = URL(string: dataURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode([ItemDataModel].self, from: data) {
                DispatchQueue.main.async {
                    self.itemDM = decodedResponse
                }
            }
        }.resume()
    }
    
    
    
    
    
    
    
    
    
    
}
