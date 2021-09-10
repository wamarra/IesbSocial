//
//  UserListView.swift
//  IesbSocial
//
//  Created by Wesley Marra on 03/09/21.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject
    var userViewModel: UserViewModel
    
    @StateObject
    var postViewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if userViewModel.loading {
                    loading()
                }else {
                    List {
                        ForEach(userViewModel.users) { user in
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
            .navigationBarItems(trailing: UserAdd(userViewModel: userViewModel))
        }
        .environmentObject(postViewModel)
        .onAppear {
            userViewModel.fetchUsers()
        }
    }
}

struct UserAdd: View {
    
    var userViewModel: UserViewModel
    
    var body: some View {
        NavigationLink(destination: UserAddView(viaCepViewModel: ViaCepViewModel()).environmentObject(userViewModel)) {
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
