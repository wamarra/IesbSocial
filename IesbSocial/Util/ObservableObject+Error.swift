//
//  ObservableObject+Error.swift
//  IesbSocial
//
//  Created by Wesley Marra on 03/09/21.
//

import Foundation
import Combine

extension ObservableObject {

    func sinkError(_ completion: Subscribers.Completion<Error>, loadingFinisher: () -> Void) {
        switch completion {
        case .failure(let error):
            loadingFinisher()
            debugPrint(error)
        default:
            break
        }
    }
}
