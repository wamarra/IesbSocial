//
//  IesbSocialApp.swift
//  IesbSocial
//
//  Created by Wesley Marra on 03/09/21.
//

import SwiftUI

@main
struct IesbSocialApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView(viewModel: UserViewModel())
        }
    }
}
