//
//  UserListView.swift
//  IesbSocial
//
//  Created by Wesley Marra on 03/09/21.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject
    var viewModel: UserViewModel
    
    @StateObject
    var postViewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.loading {
                    loading()
                }else {
                    List {
                        ForEach(viewModel.users) { user in
                            NavigationLink(destination: PostListView(user: user)) {
                                VStack(alignment: .leading) {
                                    Text(user.name).font(.title2)
                                    Text(user.email).font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Usuários")
            .navigationBarItems(trailing: UserAdd(viewModel: viewModel))
        }
        .environmentObject(postViewModel)
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

struct UserAdd: View {
    
    var viewModel: UserViewModel
    
    var body: some View {
        NavigationLink(destination: UserAddView(viewModel: viewModel)) {
           Text(" + ")
            .navigationBarTitle("Adicionar Usuário")
            .frame(minWidth: 0, maxWidth: 100)
            .padding(EdgeInsets.init(top: 3, leading: 5, bottom: 5, trailing: 5))
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(50)
            .font(.title)
       }
    }
}
