//
//  SignUpView.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-25.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email : String = ""
    @State private var fullName : String = ""
    @State private var password : String = ""
    @State private var telephone : String = ""
    @State private var confirmPwd : String = ""
    @StateObject var signVM = SignUpViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            //image
            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width:100,height:120)
                Text("The Z Store")
                    .bold()
            }
            .padding(.vertical,32)
            
            
            //form field
            
            VStack{
                UserInputView(text: $email, title: "Email Address", placeHolder: "name@example.com")
                    .textInputAutocapitalization(.never)
                
                UserInputView(text: $fullName, title: "Full Name", placeHolder: "Full Name")
                
                UserInputView(text: $telephone, title: "Telephone Number", placeHolder: "Telephone Number")
                
                UserInputView(text: $password, title: "Password", placeHolder: "Password")
                
                UserInputView(text: $confirmPwd, title: "Confirm Password", placeHolder: "Confirm Password")
                
                if signVM.showError {
                    Text(signVM.errorMessage)
                        .font(.system(size: 14))
                        .foregroundStyle(.red)
                }
                
                if signVM.showSuccess {
                    
                    Text("You have successfully registered !")
                        .font(.system(size: 14))
                        .foregroundStyle(.green)
                }
                
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            //sign in button
            
            Button{
                signVM.registerUser(email: email, name: fullName, telephone: telephone, confPwd: confirmPwd, password: password)
            } label: {
                HStack{
                    Text("REGISTER")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32,height:48)
            }
            .background(Color(.systemBlue))
            .cornerRadius(50)
            .padding(.top,24)
            
            Spacer()
            
            Button{
                dismiss()
            } label: {
                HStack{
                    HStack(spacing: 3){
                        Text("Already Registered?")
                        Text("Sign in")
                            .bold()
                    }
                    .font(.system(size: 14))
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    SignUpView()
}
