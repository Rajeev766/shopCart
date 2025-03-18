////
////  ShoppingCartView.swift
////  shopCart
////
////  Created by Rajeev Choudhary on 10/03/25.
////
//
//import SwiftUI
//
//struct ShoppingCartView: View {
//    @EnvironmentObject var viewModel: CartViewModel
//
//    let columns = [
//        GridItem(.flexible(), spacing: 4),
//        GridItem(.flexible(), spacing: 4)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                VStack {
//                    Text("Shopping Cart")
//                        .font(.title)
//                        .bold()
//                        .padding()
//                    
//                    ScrollView {
//                        LazyVGrid(columns: columns, spacing: 4) {
//                            ForEach(viewModel.products) { product in
//                                ProductCard(product: product)
//                            }
//                        }
//                        .padding()
//                    }
//                }
//
//                FloatingCartButton()
//            }
//            .onAppear {
//                viewModel.fetchProducts()
//            }
//        }
//    }
//}
//
//struct ProductCard: View {
//    let product: Product
//    @EnvironmentObject var viewModel: CartViewModel
//
//    var body: some View {
//        VStack {
//            AsyncImage(url: URL(string: product.images.first ?? "")) { image in
//                image.resizable()
//                    .scaledToFit()
//                    .frame(height: 100)
//            } placeholder: {
//                ProgressView()
//            }
//            
//            Text(product.title)
//                .font(.headline)
//                .lineLimit(1)
//            
//            Text(product.description)
//                .font(.subheadline)
//                .lineLimit(2)
//                .foregroundColor(.gray)
//                .padding(.horizontal, 5)
//            
//            Text("Rs. \(product.price, specifier: "%.2f")")
//                .font(.subheadline)
//                .bold()
//            
//            Button(action: {
//                viewModel.addToCart(product: product)
//                print("Added to Cart '\(product.title)'")
//            }) {
//                Text("Add to Cart")
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.gray)
//                    .cornerRadius(8)
//            }
//        }
//        .padding()
//        .frame(width: 200, height: 320)
//        .background(Color.gray.opacity(0.2))
//        .cornerRadius(10)
//    }
//}
//
//struct FloatingCartButton: View {
//    @EnvironmentObject var viewModel: CartViewModel
//
//    var body: some View {
//        VStack {
//            Spacer()
//            HStack {
//                Spacer()
//                NavigationLink(destination: ViewCart().environmentObject(CartViewModel.shared)) {
//                    ZStack {
//                        Image(systemName: "cart")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Circle().fill(Color.gray))
//
//                        if viewModel.cartItemCount > 0 {
//                            Text("\(viewModel.cartItemCount)")
//                                .font(.caption)
//                                .bold()
//                                .foregroundColor(.white)
//                                .padding(6)
//                                .background(Circle().fill(Color.red))
//                                .offset(x: 15, y: -15)
//                        }
//                    }
//                }
//                .padding()
//            }
//        }
//    }
//}
//
//extension View {
//    func cartBadgeStyle() -> some View {
//        self
//            .font(.caption)
//            .bold()
//            .foregroundColor(.white)
//            .padding(6)
//            .background(Color.red)
//            .clipShape(Circle())
//            .offset(x: 15, y: -15)
//    }
//}
//
//struct ShoppingCartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingCartView()
//            .environmentObject(CartViewModel())
//    }
//}
