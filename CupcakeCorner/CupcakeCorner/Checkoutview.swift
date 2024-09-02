//
//  Checkoutview.swift
//  CupcakeCorner
//
//  Created by Andres Rivillas on 15/02/24.
//

import SwiftUI


struct Checkoutview: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var shoulShowError = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                           scale: 3){ image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order"){
                    Task{
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Gracias", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert(isPresented: $shoulShowError, error: MyError.someError) { _ in
              Button("OK") {
                // Handle acknowledgement.
                  shoulShowError = false
              }
            } message: { error in
              Text("Try again later.")
            }
    }
    
    enum MyError: LocalizedError {
      case someError

      var errorDescription: String? {
        switch self {
        case .someError:
          return "Something went wrong"
        }
      }

      var recoverySuggestion: String? {
        switch self {
        case .someError:
          return "Please try again."
        }
      }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("FAil")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is now the way!"
            showingConfirmation = true
        } catch {
            shoulShowError = true
            print("Error")
        }
    }
}

#Preview {
    Checkoutview(order: Order())
}
