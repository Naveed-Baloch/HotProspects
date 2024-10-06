//
//  Prospect.swift
//  HotProspects
//
//  Created by Naveed on 06/10/2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
