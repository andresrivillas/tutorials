//
//  ContentView.swift
//  AsyncAwaitPractice
//
//  Created by Andres Rivillas on 3/12/23.
//

import SwiftUI

class AsyncAwaiyPracticeViewModel: ObservableObject {
    @Published var data: [String] = []
    
    func addTitle1(){
        DispatchQueue.main.async{
            self.data.append("Main Thread 1: \(Thread.current)")
        }
    }
    
    func addTitle2(){
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5){
            self.data.append("Global Thread 1: \(Thread.current)")
            DispatchQueue.main.async {
                self.data.append("Main Thread 2: \(Thread.current)")
            }
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = AsyncAwaiyPracticeViewModel()
    var body: some View {
        List {
            ForEach(viewModel.data, id: \.self) { data in
                Text(data)
            }
        }.onAppear{
            viewModel.addTitle1()
            viewModel.addTitle2()
        }
    }
}

func getUserId(_ completion: @escaping (Int) -> Void) {
    DispatchQueue.main.asyncAfter (deadline: .now() + 2) {
        completion(42)
    }
}

func getUserId() async -> Int {
    return await withUnsafeContinuation { continuation in
        getUserId { userId in
            continuation.resume(returning: userId)
        }
    }
}

func getUserFirstName(userId: Int, _ completion: @escaping (String) -> Void) {
    DispatchQueue.main.asyncAfter (deadline: .now() + 2) {
        completion("Vincent")
    }
}

func getUserFirstName(userId: Int) async -> String {
    return await withUnsafeContinuation { continuation in
        getUserFirstName(userId: userId) { name in
            continuation.resume(returning: name)
        }
    }
}

func getUserLastName (userId: Int, _ completion: @escaping (String) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        completion("Pradeilles")
    }
}

func getUserLastName(userId: Int) async -> String {
    return await withUnsafeContinuation { continuation in
        getUserLastName(userId: userId) { lastName in
            continuation.resume(returning: lastName)
        }
    }
}

func greetUser() async {
    let userId = await getUserId()
    async let firstName = getUserFirstName(userId: userId)
    async let lastName = getUserLastName(userId: userId)
    
    await print("Hello \(firstName) \(lastName)")
}

#Preview {
    ContentView()
}

