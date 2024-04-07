//
//  HomeView.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM: HomeViewModel = HomeViewModel()
    @StateObject var itemVM: ItemViewModel = ItemViewModel()
    @StateObject var userVM: UserViewModel = UserViewModel()
    @StateObject var categoryVM: CategoryViewModel = CategoryViewModel()
    @StateObject var cartVM: CartViewModel = CartViewModel()
    @StateObject var favVM: FavouriteViewModel = FavouriteViewModel()
    @State private var selectedCategory: String?
    @State private var searchString: String = ""
    @State private var sortOrder: SortOrder = .none
    @State private var isShowingSideMenu = false
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 0)]
    
    enum SortOrder {
        case none, lowToHigh, highToLow
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Main content view
                mainContent
                    .blur(radius: isShowingSideMenu ? 20 : 0)
                    .disabled(isShowingSideMenu)
                    .navigationBarItems(leading: menuButton)
                
                // Side menu view
                if isShowingSideMenu {
                    SideMenuView(isShowing: $isShowingSideMenu)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
    
    
    
    
    
    
    var mainContent: some View {
            ScrollView {
                VStack(spacing: 20) {
                    ScrollView {
                        VStack(spacing: 20) {
                            welcomeBand
                            searchBar
                            categoriesView
                            itemsGrid
                        }
                        .padding(.top)
                    }
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
                    .preferredColorScheme(.light)
                
                

                }
                .padding(.top)
            }
        }
    
    
    
    var menuButton: some View {
            Button(action: {
                withAnimation {
                    isShowingSideMenu.toggle()
                }
            }) {
                Image(systemName: "list.bullet")
                    .imageScale(.large)
            }
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
           
    var welcomeBand: some View {
        HStack {
            // Sorting button
            Menu {
                        Button("Price: Low to High", action: {
                            sortOrder = .lowToHigh
                            itemVM.sortItems(by: .lowToHigh)
                        })
                        Button("Price: High to Low", action: {
                            sortOrder = .highToLow
                            itemVM.sortItems(by: .highToLow)
                        })
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .padding(.trailing)
                    }

                    Spacer()

            Text(userVM.authenticated ? "Hello, \(userVM.username)!" : "Hello, Welcome!")
                .font(.headline)
                .padding(.horizontal)

            Spacer()

            NavigationLink(destination: CartView().toolbar(.hidden, for:.tabBar)) {
                CartButton(numberOfProducts: cartVM.items.count)
            }
        }
        .padding(.vertical)
        .background(Color("DefaultRectangleBg"))
        .cornerRadius(20)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
        .padding(.horizontal)
        .onAppear {
            if userVM.authenticated {
                cartVM.fetchCartData(forEmail: userVM.username)
            }
        }
    }

    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("What are you looking for...", text: $searchString)
                .onChange(of: searchString) { _ in
                    itemVM.fetchData(category: selectedCategory ?? "All", searchString: searchString)
                }
        }
        .padding()
        .background(Color("DefaultRectangleBg"))
        .cornerRadius(20)
        .padding(.horizontal)
    }

    var categoriesView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Categories:")
                .font(.headline)
                .padding(.horizontal)

            ForEach(categoryVM.categories, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                    itemVM.fetchData(category: category, searchString: searchString)
                }) {
                    CategoryButton(title: category, isSelected: selectedCategory == category)
                }
            }
        }
        .padding(.horizontal)
    }

    var itemsGrid: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(itemVM.itemDM) { item in
                ClothingCard(itemDM: item, favVM: favVM, userVM: userVM)
            }
        }
        .padding(.horizontal)
    }
}

struct CategoryButton: View {
    var title: String
    var isSelected: Bool

    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(isSelected ? .white : .black)
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(isSelected ? Color.blue : Color("DefaultRectangleBg"))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
            .padding(.vertical, 5)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
