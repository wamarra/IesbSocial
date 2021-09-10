//
//  User.swift
//  IesbSocial
//
//  Created by Wesley Marra on 03/09/21.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    var name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
    
    init(name: String, email: String, phone: String, website: String) {
        self.id = UUID().hashValue
        self.name = name
        self.username = ""
        self.email = email
        self.address = Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: ""))
        self.phone = phone
        self.website = website
        self.company = Company(name: "", catchPhrase: "", bs: "")
    }
}

struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat, lng: String
}

struct Company: Codable {
    let name, catchPhrase, bs: String
}
