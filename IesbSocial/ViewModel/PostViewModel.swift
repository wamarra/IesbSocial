//
//  PostViewModel.swift
//  IesbSocial
//
//  Created by Wesley Marra on 03/09/21.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    
    private let kBaseURL = "https://jsonplaceholder.typicode.com"
       
    @Published
    private(set) var loading = false

    @Published
    private(set) var posts = [Post]() {
       didSet {
           loading = false
       }
    }

    private var postCancellationToken: AnyCancellable?
    
    func fetchPosts(for user: User) {
        if let url = URL(string: "\(kBaseURL)/users/\(user.id)/posts") {
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            loading = true
            
            postCancellationToken = session.dataTaskPublisher(for: request)
                .tryMap(session.map(_:))
                .decode(type: [Post].self, decoder: JSONDecoder())
                .breakpointOnError()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {self.sinkError($0) { self.loading = false }}) { self.posts = $0 }
        }
    }
    
}
