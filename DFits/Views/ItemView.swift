import SwiftUI

struct ItemView: View {
    
    @StateObject var itemVM : ItemViewModel = ItemViewModel()
    @State private var getSelection:Int = 0
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Image("sampleMen")
                    .resizable()
                    .cornerRadius(10)
                    .frame(width: 350,height: 450)
                    .scaledToFit()
                Spacer()
                VStack{
                    HStack{
                        Text("Cloth Name")
                        Spacer()
                        Text("$ 0.00")
                    }
                    .padding()
                }
                //Spacer()
                VStack{
                    HStack{
                        Circle()
                            .frame(width: 40)
                            .foregroundColor(getSelection != 0 ? Color.gray : Color.black)
                            .overlay{
                                Button(action: {
                                    getSelection = 0
                                }, label: {
                                    Text("S")
                                })
                                .tint(.white)
                                
                            }
                        Circle()
                            .frame(width: 40)
                            .foregroundColor(getSelection != 1 ? Color.gray : Color.black)
                            .overlay{
                                Button(action: {
                                    getSelection = 1
                                }, label: {
                                    Text("M")
                                })
                                .tint(.white)
                                
                            }
                        Circle()
                            .frame(width: 40)
                            .foregroundColor(getSelection != 2 ? Color.gray : Color.black)
                            .overlay{
                                Button(action: {
                                    getSelection = 2
                                }, label: {
                                    Text("L")
                                })
                                .tint(.white)
                                
                            }
                        Circle()
                            .frame(width: 40)
                            .foregroundColor(getSelection != 3 ? Color.gray : Color.black)
                            .overlay{
                                Button(action: {
                                    getSelection = 3
                                }, label: {
                                    Text("XL")
                                })
                                .tint(.white)
                                
                            }
                    }
                }
                Spacer()
                Button{
                    print("user login")
                } label: {
                    HStack{
                        Text("CHECKOUT")
                            .foregroundStyle(.white).bold()
                        Image(systemName: "arrow.forward")
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32,height:48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(50)
                //Spacer()
            }
            
        }
        //.ignoresSafeArea()
    }
}
#Preview {
    ItemView()
}
