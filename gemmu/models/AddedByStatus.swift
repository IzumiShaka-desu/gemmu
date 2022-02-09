//
//  AddedByStatus.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//

import Foundation
struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int
    let dropped, playing: Int
}
