//
//  Post.swift
//  IesbSocial
//
//  Created by Wesley Marra on 03/09/21.
//

import Foundation

struct Post: Codable, Identifiable {
    let userId, id: Int
    let title, body: String
}

