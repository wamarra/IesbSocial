//
//  Cep.swift
//  IesbSocial
//
//  Created by Wesley Marra on 09/09/21.
//

import Foundation

struct ViaCep: Codable {
    let cep, logradouro, complemento, bairro: String
    let localidade, uf, ibge, gia: String
    let ddd, siafi: String
}
