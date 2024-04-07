import SwiftUI

struct ItemDetailView: View {
    @StateObject var itemDetailsVM = ItemDetailViewModel()
    @State var getSelection: String = "S"
    @State var quantity: Int = 1
    @State private var showAlert = false
    var itemDM: ItemDataModel
    var userID: String
    let sizes = ["XS", "S", "M", "L", "XL"]

    var body: some View {
        VStack {
            let imageURL = URL(string: itemDM.prod_image)!
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: .infinity, height: 320)
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: .infinity, height: 320)
                        .scaledToFill()
                        .padding()
                case .failure:
                    Image("placeholder")
                        .resizable()
                        .frame(width: .infinity, height: 320)
                        .scaledToFit()
                        .padding()
                @unknown default:
                    EmptyView()
                }
            }

            Text(itemDM.prod_name)
                .font(.title)
                .padding(.top)
            Text("$ \(itemDM.prod_price, specifier: "%.2f")")
                .font(.title2)
                .padding(.bottom)

            Text("Select Size:")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            HStack {
                ForEach(sizes, id: \.self) { size in
                    Button(action: {
                        getSelection = size
                    }) {
                        Text(size)
                            .font(.headline)
                            .foregroundColor(getSelection == size ? .white : .black)
                            .frame(width: 50, height: 50)
                            .background(getSelection == size ? Color.blue : Color.gray)
                            .clipShape(Circle())
                    }
                }
            }
            .padding()

            HStack {
                Text("Quantity:")
                    .font(.headline)
                Stepper(value: $quantity, in: 1...10) {
                    Text("\(quantity)")
                        .font(.system(size: 13))
                }
            }
            .padding()

            Button(action: {
                if userID.isEmpty {
                    showAlert = true
                } else {
                    itemDetailsVM.addToCart(itemID: "\(itemDM.id)", userID: userID, size: getSelection, qty: "\(quantity)")
                    showAlert = false
                }
            }) {
                HStack {
                    Text("ADD TO CART")
                        .foregroundColor(.white)
                        .bold()
                    Image(systemName: "cart.fill")
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                .background(Color.blue)
                .cornerRadius(24)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Unable to Add to Cart"),
                    message: Text("Please log in before adding items to your cart.")
                )
            }
            .padding(.top)
        }
        .padding()
        .navigationBarTitle("Item Details", displayMode: .inline)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(itemDM: ItemDataModel(id: 1, prod_name: "Sample Item", prod_image: "https://example.com/image.jpg", prod_price: 29.99), userID: "user@example.com")
    }
}
