//
//  UserAddView.swift
//  IesbSocial
//
//  Created by Wesley Marra on 06/09/21.
//

import SwiftUI

struct UserAddView: View {
    
    @ObservedObject
    var viewModel: UserViewModel
    
    @State private var showingAlert = false
    @State private var backToUserListView = false
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                TextField("Nome: ",text: $name)
                TextField("Username: ",text: $username)
                TextField("email: ",text: $email)
            }
        }
        
        Button("Salvar") {
            viewModel.addUser(user: User(name: name, username: username, email: email))
            showingAlert = true
            name = ""
            username = ""
            email = ""
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Sucesso"), message: Text("Usuário cadastrado com sucesso"), dismissButton: .default(Text("OK")))
        }
    }
}

