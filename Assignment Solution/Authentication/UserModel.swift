//
//  User.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 19/05/24.
//
import Foundation

struct User: Codable {
    var name: String
    var mobile: String
    var email: String
    var encryptedPassword: Data
}
