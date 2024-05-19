//
//  Note.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 19/05/24.
//

import Foundation
import SwiftUI

struct Note: Identifiable, Codable {
    var id: UUID
    var title: String
    var description: String
    var photos: [Data]
}
