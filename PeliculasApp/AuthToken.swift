//
//  AuthToken.swift
//  PeliculasApp
//
//  Created by michcode on 10/28/20.
//

import Foundation

struct AuthToken: Codable {
    
    let token: String
    let email: String
    let nicename: String
    let displayName: String
    
    enum codingKeys: String, CodingKey {
        case token
        case email = "user_email"
        case nicename = "user_nicename"
        case displayName = "user_display_name"
    }
}
