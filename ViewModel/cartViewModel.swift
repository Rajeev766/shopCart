//
//  cartViewModel.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 10/03/25.
//

import SwiftUI

struct ProductResponse: Decodable {
    let products: [Product]
}

struct Product: Identifiable, Decodable {
    let id: Int
    let images: [String]
    let title: String
    let description: String
    let price: Double
    var stock: Int
}

class CartViewModel: ObservableObject {
    static let shared = CartViewModel()
    
    @Published var products: [Product] = []
    @Published var cartItems: [Int: Int] = [:]
    @StateObject private var viewModel = CartViewModel()

    // property for total item count
    var cartItemCount: Int {
        cartItems.values.reduce(0, +)
    }

    // Adding a product to the cart
    func addToCart(product: Product) {
        if cartItems[product.id] != nil {
            showReAddConfirmation(product: product)
        } else {
            cartItems[product.id] = 1
        }
    }

    // Increase the quantity of a product in the cart
    func increaseQuantity(for productId: Int) {
        cartItems[productId, default: 0] += 1
    }

    // Decrease the quantity of a product in the cart
    func decreaseQuantity(for productId: Int) {
        if let quantity = cartItems[productId], quantity > 1 {
            cartItems[productId] = quantity - 1
        } else {
            cartItems.removeValue(forKey: productId)
        }
    }

    // Show a confirmation alert when adding an item that's already in the cart
    private func showReAddConfirmation(product: Product) {
        let alert = UIAlertController(
            title: "Item Already Added",
            message: "Do you want to add this item again?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.cartItems[product.id, default: 0] += 1
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(alert, animated: true)
            }
        }
    }

    //API for products listing
    func fetchProducts() {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.products = decodedResponse.products
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }
}


