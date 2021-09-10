//
//  UserAddView.swift
//  IesbSocial
//
//  Created by Wesley Marra on 06/09/21.
//

import SwiftUI

struct UserAddView: View {
    
    @EnvironmentObject
    var userViewModel: UserViewModel

    @ObservedObject
    var addressViewModel: ViaCepViewModel
    
    @State private var showingAlert = false
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var website = ""
    
    @State private var cep = ""
    @State private var logradouro = ""
    @State private var uf = ""
    
    @Environment(\.presentationMode)
    var presentationMode
    
    var body: some View {
        Group {
            if userViewModel.loading {
                loading()
            } else {
                List {
                    Section(header: Text("Dados pessoais")) {
                        FormField(
                            label: "Nome:",
                            placeholder: "Fulano da Silva",
                            text: $name
                        )
                        FormField(
                            label: "E-mail:",
                            placeholder: "fulano.silva@mail.com",
                            text: $email
                        )
                        .keyboardType(.emailAddress)
                        FormField(
                            label: "Telefone:",
                            placeholder: "(00) 00000-0000",
                            text: $phone
                        )
                        .keyboardType(.phonePad)
                        FormField(
                            label: "Site:",
                            placeholder: "https://www.fulandosilva.com.br",
                            text: $website
                        )
                    }
                    
                    Section(header: Text("Endereço")) {
                        FormField(
                            label: "CEP:",
                            placeholder: "00000-000",
                            text: $cep
                        )
                        .keyboardType(.numberPad)
                        FormField(
                            label: "Logradouro:",
                            placeholder: "Rua x ",
                            text: $logradouro
                        )
                        FormField(
                            label: "UF:",
                            placeholder: "DF",
                            text: $uf
                        )
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .alert(isPresented: $showingAlert) {
                    if let error = userViewModel.error {
                        return Alert(title: Text("Opa! Aconteceu algo"), message: Text(error), dismissButton: .default(Text("OK")))
                    } else {
                        return Alert(title: Text("Sucesso"), message: Text("Usuário cadastrado com sucesso"), dismissButton: .default(Text("OK")) {
                            self.presentationMode.wrappedValue.dismiss()
                        })
                    }
                }
            }
        }
        .navigationTitle(name)
        .navigationBarItems(trailing: Button("Salvar") {
            userViewModel.addUser(user: User(name: name, email: email, phone: phone, website: website), bindingAlert: $showingAlert)
            showingAlert = true
        })
        .onChange(of: cep, perform: { value in
            if value.count == 8 {
                addressViewModel.fetchCep(cep: cep)
            }
        })
        .onReceive(addressViewModel.$viaCep, perform: { viaCep in
            logradouro = viaCep?.logradouro ?? ""
            uf = viaCep?.uf ?? ""
        })
    }
}

fileprivate struct FormField: View {
    
    let label: String
    let placeholder: String
    let text: Binding<String>
    let required = true
    let readonly = false
    
    let labelColor = Color.black.opacity(0.65)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .foregroundColor(labelColor)
                if required {
                    Text("*")
                        .foregroundColor(.red)
                }
            }
            .font(Font.caption)
            if readonly {
                Text(text.wrappedValue)
            }else {
                TextField(placeholder, text: text)
            }
        }
    }
}
