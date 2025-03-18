//
//  ViewCart.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 10/03/25.
//

import SwiftUI

struct ViewCart: View {
    @EnvironmentObject var viewModel: CartViewModel

    var body: some View {
        VStack {
            Text("My Cart")
                .font(.title)
                .bold()
                .padding()

            if viewModel.cartItems.isEmpty {
                Text("Your cart is empty.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(viewModel.products.filter { viewModel.cartItems[$0.id] != nil }) { product in
                        HStack {
                            // Product Image
                            AsyncImage(url: URL(string: product.images.first ?? "")) { image in
                                image.resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(5)

                            VStack(alignment: .leading) {
                                Text(product.title)
                                    .font(.subheadline)
                                    .bold()
                                Text("$\(product.price * Double(viewModel.cartItems[product.id] ?? 1), specifier: "%.2f")")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            // Decrease Button
                            Button(action: {
                                viewModel.decreaseQuantity(for: product.id)
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title2)
                            }

                            Text("\(viewModel.cartItems[product.id]!)") // Display quantity
                                .font(.headline)
                                .padding(.horizontal, 10)

                            // Increase Button
                            Button(action: {
                                viewModel.increaseQuantity(for: product.id)
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
//                Text("Total: $\(Product.reduce(0) { $0 + $1.Product.price * Double($1.stock) })")
//                        .font(.headline)
//                        .padding()
            }

            Spacer()

            Button(action: {
                print("Proceed to Checkout")
            }) {
                Text("Checkout")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom)
        }
    }
}

struct ViewCart_Previews: PreviewProvider {
    static var previews: some View {
        ViewCart()
            .environmentObject(CartViewModel())
    }
}
