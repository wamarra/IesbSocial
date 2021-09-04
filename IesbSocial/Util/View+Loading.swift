//
//  View+Loading.swift
//  IesbSocial
//
//  Created by Wesley Marra on 03/09/21.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func loading() -> some View {
        VStack {
            ProgressView()
            Text("Aguarde... carregando...")
        }
    }
}
