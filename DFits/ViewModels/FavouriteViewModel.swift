import Foundation
import SwiftUI

class FavouriteViewModel : ObservableObject {
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var showSuccess: Bool = false
    //@Published var favItemDM = [ItemDataModel]()
    //@Published private(set) var items: [ItemDataModel] = []
    @Published var items: [ItemDataModel] = []
    
    
    func addToFavourites(item_id: String,user_id: String){
        guard let url = URL(string: "http://localhost:3000/api/favourites") else {
            print("Invalid URL")
            return
        }
        //let tel = (telephone as NSString).integerValue
        let userData = FavouriteDataModel(item_id: item_id, user_id: user_id)
        guard let jsonData = try? JSONEncoder().encode(userData) else {
            self.showError = true
            self.errorMessage = "Failed to encode favourite data"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                self.showError = true
                //self.errorMessage = "Error: \(error?.localizedDescription ?? "Unknown error")"
                self.errorMessage = "something went wrong"
                return
            }
            
            if httpResponse.statusCode == 200 {
                self.showSuccess = true
            }
        }.resume()
    }
    
    func fetchFavouriteItems(forEmail email: String) {
        guard let url = URL(string: "http://localhost:3000/api/favourites/\(email)") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([ItemDataModel].self, from: data)
                DispatchQueue.main.async {
                    self.items = decodedData
                }
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }.resume()
    }
    
    //@Published var errorMessage: String?
    
    func deleteFavouriteItem(ForItemID id: String) {
        guard let url = URL(string: "http://localhost:3000/api/favourites/\(id)") else {
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
    
    func removeFromFavourite(item : ItemDataModel){
        items = items.filter { $0.id != item.id }
    }
    
}
