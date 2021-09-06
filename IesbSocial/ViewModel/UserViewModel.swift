//
//  UserViewModel.swift
//  IesbSocial
//
//  Created by Wesley Marra on 03/09/21.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    private let kBaseURL = "https://jsonplaceholder.typicode.com"
       
    @Published
    private(set) var loading = false

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
    
    func addUser(user: User) {
        self.users.append(user)
    }
}
