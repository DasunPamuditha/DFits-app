//
//  UserView.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//


import SwiftUI

struct UserView: View {
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var showEmail : String = ""
    @State private var showName : String = ""
    @StateObject var userVM = UserViewModel()
    @ObservedObject var viewModel = UserViewModel()
    
    var body: some View {
        NavigationStack{
            if userVM.authenticated{
                NavigationStack{
                    ZStack{
                        VStack{
                            Spacer()
                            List{
                                Section{
                                    HStack{
                                        Image("logo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 72,height: 72)
                                            .clipShape(Circle())
                                        VStack(alignment: .leading,spacing: 4){
                                            //fetch user
                                            if let user = userVM.user{
                                                Text("\(user.name)")
                                                    .font(.title)
                                                Text("\(user.email)")
                                                    .foregroundStyle(.gray)
                                            } else {
                                                Text("Loading...")
                                                    .onAppear {
                                                        //viewModel.fetchUser(email: email)
                                                        userVM.fetchUser(email: userVM.username)
                                                    }
                                            }
                                            
                                        }
                                    }
                                }
                                
                                
                                
                                Section("Settings"){
                                    VStack(alignment: .center,
                                           spacing: 20){
                                        Button{
                                            password=""
                                            email=""
                                            userVM.logout()
                                        }label:{
                                            HStack{
                                                HStack(spacing: 3){
                                                    Text("Want to Exit?")
                                                    Text("Sign out")
                                                        .bold()
                                                }
                                                .font(.system(size: 14))
                                                .tint(.red)
                                            }
                                        }
                                    }.frame(maxWidth: .infinity)
                                }
                                
                            }
                            .opacity(0.8)
                            Spacer()
                            
                        }
                    }
                }
            }else{
                //image
                
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width:100,height:120)
                    .padding(.vertical,32)
                
                //form field
                
                VStack{
                    UserInputView(text:$email, title: "Email Address", placeHolder: "name@example.com")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    UserInputView(text:$password, title: "Password", placeHolder: "Password", isSecureField: true)
                    
                }
                .padding(.horizontal)
                .padding(.vertical)
                if userVM.showError {
                    Text(userVM.errorMessage)
                        .foregroundStyle(.red)
                        .font(.system(size: 14))
                }else{
                    //userVM.getUser(email: "")
                    Text("")
                }
                //sign in button
                
                Button(action:{
                    //userVM.verifyLogin()
                    userVM.login(email: email, password: password)
                },label: {
                    HStack{
                        Text("SIGN IN")
                            .foregroundStyle(.white).bold()
                        //Image(systemName: "arrow.forward")
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32,height:48)
                })
                .background(Color(.systemBlue))
                .cornerRadius(50)
                .padding(.top,24)
                
                Spacer()
                
                //sign up button
                
                NavigationLink{
                    SignUpView()
                } label : {
                    HStack(spacing: 3){
                        Text("Haven't Registered Yet?")
                        Text("Register Now")
                            .bold()
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

#Preview {
    UserView()
}
