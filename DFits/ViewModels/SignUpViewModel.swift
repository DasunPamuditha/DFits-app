//
//  SignUpViewModel.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-30.
//

import Foundation
import SwiftUI


class SignUpViewModel : ObservableObject {
    @Published var showError : Bool = false
    @Published var errorMessage : String = ""
    @Published var showSuccess : Bool = false
    
    func registerUser(email: String, name: String, telephone: String,confPwd: String , password: String) {
        if email.isEmpty {
            showError = true
            errorMessage = "Email cannot be empty"
        } else if name.isEmpty {
            showError = true
            errorMessage = "Name cannot be empty"
        }else if password.isEmpty {
            showError = true
            errorMessage = "Password cannot be empty"
        }else if confPwd.isEmpty {
            showError = true
            errorMessage = "You must confirm the password"
        } else if password != confPwd {
            showError = true
            errorMessage = "Password must be matched"
        } else {
            guard let url = URL(string: "http://localhost:3000/api/users/register") else {
                print("Invalid URL")
                return
            }
            let tel = (telephone as NSString).integerValue
            let userData = SignUpDataModel(email: email, name: name, telephone: tel, password: password)
            guard let jsonData = try? JSONEncoder().encode(userData) else {
                self.showError = true
                self.errorMessage = "Failed to encode user data"
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
                    self.errorMessage = "User exits or something went wrong"
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    self.showSuccess = true
                }
            }.resume()
        }
    }
}
