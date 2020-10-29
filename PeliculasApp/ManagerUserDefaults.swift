//
//  ManagerUserDefaults.swift
//  PeliculasApp
//
//  Created by michcode on 10/28/20.
//

import UIKit
class ManagerUserDefaults {
    // DIFERENTES FUNCIONES PARA PERSISTIR DATOS EN EL DISPOSITIVO
    
    func existKeyInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func deleteValueUserDefaultWith(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func saveAuthToken(key: String, value: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func retrieveToken(key: String) -> String {
        guard let authToken = UserDefaults.standard.string(forKey: key) else {
            return "No hay registro de token"
        }
        return authToken
    }
    
    //MARK: -SINGLETON
    static let sharedInstance: ManagerUserDefaults = {
        let instance = ManagerUserDefaults()
        return instance
    }()
}
