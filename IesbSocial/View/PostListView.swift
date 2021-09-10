//
//  PostListView.swift
//  IesbSocial
//
//  Created by Wesley Marra on 03/09/21.
//

import SwiftUI

struct PostListView: View {
    
    @EnvironmentObject
    var postViewModel: PostViewModel
    
    var user: User
    
    var body: some View {
        VStack {
            if postViewModel.loading {
                loading()
            }else {
                List {
                    ForEach(postViewModel.posts) { post in
                        VStack(alignment: .leading) {
                            Text(post.title).font(.title2)
                            Text(post.body).font(.subheadline)
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .onAppear {
            postViewModel.fetchPosts(for: user)
        }
    }
}
