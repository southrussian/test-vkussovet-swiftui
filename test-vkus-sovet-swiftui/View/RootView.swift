//
//  ContentView.swift
//  test-vkus-sovet-swiftui
//
//  Created by Danil Peregorodiev on 25.09.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = RootViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {

                    header

                    categoriesView
                    .padding(.top, 20)
                    
                    Text(viewModel.menuItems.indices.contains(viewModel.selectedCategoryIndex) ? viewModel.menuItems[viewModel.selectedCategoryIndex].name : "")
                        .font(.system(.title, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 20) // наименование текущего раздела меню
                    itemsGridView
                    
                }
                .padding(.horizontal, 7)
            }
            .onAppear {
                viewModel.fetchData()
                viewModel.fetchItems()
            }
        }
    }
}

extension HomeView {
    var vkussovet: some View {
        HStack {
            Circle()
                .frame(width: 45)
                .foregroundColor(.white)
                .overlay(alignment: .center) {
                    Image(systemName: "fork.knife.circle")
                        .foregroundColor(.red)
                        .background(.black)
                        .cornerRadius(12)
                        .scaleEffect(1.6)
                }
            Text("vkussovet".uppercased())
                .font(.system(.title2, weight: .bold))
                .foregroundColor(.white)

        }
    }
    
    var header: some View {
        HStack {
            vkussovet
            Spacer()
            Button {
            } label: {
                Image(systemName: "phone")
                    .font(.system(.title3, weight: .bold))
                    .foregroundColor(.white)
            }
        }
    }
    
    var categoriesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(viewModel.menuItems.indices, id: \.self) { index in
                    let menuItem = viewModel.menuItems[index]
                    VStack(spacing: 10) {
                        RemoteImageView(urlString: menuItem.image)
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 9)
                        Text(menuItem.name)
                            .font(.system(.headline, weight: .semibold))
                        Text("\(menuItem.subMenuCount) товаров")
                            .foregroundColor(Color.white.opacity(0.7))
                            .padding(.bottom)
                            .font(.system(.headline))
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 5.5)
                    .background(viewModel.selectedCategoryIndex == index ? Color.blue : Color.gray)
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation(.linear) {
                            viewModel.selectedCategoryIndex = index
                            viewModel.selectedMenuID = viewModel.menuItems[viewModel.selectedCategoryIndex].menuID
                            viewModel.fetchItems()
                        }
                    }
                }
            }
        }
    }
    
    var itemsGridView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: viewModel.columns, alignment: .leading, spacing: 10) {
                ForEach(viewModel.categoryItems, id: \.id) { item in
                    VStack {
                        VStack {
                            Text(item.name)
                                .font(.system(.headline, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.top, 8)
                            
                            Text(item.content)
                                .font(.system(.caption, weight: .medium))
                                .foregroundColor(Color.white.opacity(0.7))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 3)
                                .padding(.top, 3)
                            
                            Spacer()
                            
                            HStack {
                                Text("\(item.price.formatPrice())")
                                    .font(.system(.headline, weight: .semibold))
                                    .foregroundColor(.white)
                                
                                Text("/ \(item.weight)")
                                    .font(.system(.subheadline, weight: .regular))
                                    .foregroundColor(Color.white.opacity(0.7))

                                if item.spicy == "Y" {
                                    Text("🌶️") // как в задании
                                }
                            }
                            
                            RemoteImageView(urlString: item.image)
                                .scaledToFill()
                                .frame(height: UIScreen.main.bounds.height / 7)
                            
                            
                        }
                        .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.height / 3.5)
                        .background(Color.black)
                        .cornerRadius(15)
                        Button {

                        } label: {
                            Text("В корзину")
                                .foregroundColor(.white)
                                .font(.system(.headline, weight: .regular))
                                .padding(.vertical, 12)
                                .padding(.horizontal, 20)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .offset(y: -30)
                    }
                }
            }
        }
    }
}
