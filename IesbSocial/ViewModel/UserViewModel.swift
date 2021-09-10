//
//  UserViewModel.swift
//  IesbSocial
//
//  Created by Wesley Marra on 03/09/21.
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    
    private let kBaseURL = "https://jsonplaceholder.typicode.com"
       
    @Published
    private(set) var loading = false
    
    @Published
    private(set) var error: String?

    @Published
    private(set) var users = [User]() {
       didSet {
           loading = false
       }
    }

    private var userCancellationToken: AnyCancellable?
    
    func fetchUsers() {
        if let url = URL(string: "\(kBaseURL)/users") {
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            loading = true
            
            userCancellationToken = session.dataTaskPublisher(for: request)
                .tryMap(session.map(_:))
                .decode(type: [User].self, decoder: JSONDecoder())
                .breakpointOnError()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {self.sinkError($0) { self.loading = false }}) { self.users = $0 }
        }
    }
    
    func addUser(user: User, bindingAlert: Binding<Bool>) {
        
        if let url = URL(string: "\(kBaseURL)/users") {
            let session = URLSession.shared
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let body = try JSONEncoder().encode(user)
                
                loading = true
                
                session.uploadTask(with: request, from: body) { data, response, error in
                    DispatchQueue.main.async {
                        self.loading = false
                        
                        if let requestError = error {
                            self.error = requestError.localizedDescription
                        }
                        
                        guard let resp = response as? HTTPURLResponse,
                              resp.statusCode >= 200,
                              resp.statusCode < 300 else {
                            self.error = "Erro ao salvar usuário"
                            return
                        }
                        
                        self.users.append(user)
                        bindingAlert.wrappedValue = true
                    }
                }.resume()
            } catch {
                bindingAlert.wrappedValue = true
                print("Erro ao salvar usuário")
                return
            }
        }
    }
}
