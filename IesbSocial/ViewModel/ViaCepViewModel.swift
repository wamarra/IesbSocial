//
//  CepViewModel.swift
//  IesbSocial
//
//  Created by Wesley Marra on 09/09/21.
//

import SwiftUI
import Combine

class ViaCepViewModel: ObservableObject {
    
    private let kBaseUrl = "https://viacep.com.br/ws/"
    
    @Published
    private(set) var loading = false
    
    @Published
    private(set) var viaCep: ViaCep? {
        didSet {
            loading = false
        }
    }
    
    private var cepCancellationToken: AnyCancellable?
    
    func fetchCep(cep: String) {
        if let url = URL(string: "\(kBaseUrl)/\(cep)/json") {
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            loading = true
            
            cepCancellationToken = session.dataTaskPublisher(for: request)
                .tryMap(session.map(_:))
                .decode(type: ViaCep.self, decoder: JSONDecoder())
                .breakpointOnError()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {self.sinkError($0) { self.loading = false }}) { self.viaCep = $0 }
            
        }
    }
}
