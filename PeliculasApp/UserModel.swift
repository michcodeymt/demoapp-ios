//
//  UserModel.swift
//  PeliculasApp
//
//  Created by michcode on 10/26/20.
//

import Foundation

// clases vs estructuras: estructuras pasa por valor, clase por referencia
struct UserModel: Codable {
    // Declarar las propiedades de mi objeto
    let status: String
    let cookie: String
    let user: User
    
    struct User: Codable {
        let id: Int
        let username: String
        let email: String
        let registered: String
    }
}
