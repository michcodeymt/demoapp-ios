//
//  ManagerConnections.swift
//  PeliculasApp
//
//  Created by michcode on 10/26/20.
//

import UIKit

class ManagerConnections {
    
    //SergioBece....Prueba
    
    // creamos una instancia del modelo de datos
    private var userModel: UserModel?
    private var authTokenModel: AuthToken?
    private var subscriptionModel: [SubscriptionModel]?
    private var menuModel: [MenuModel]?
    
    
    // Haga una llamada a un servicio Rest para hacer login
    // CLOSURE CON ESCAPE
    func callLoginWith(user: String, password: String, completion: @escaping (UserModel) -> ()) {
        // URL SESSION -> equivalente a ALAMOFIRE
        
        // CREAMOS LA SESION
        let session = URLSession.shared
        
        // Creamos la request con la url
        var request = URLRequest(url: URL(string: "https://www.mentoriavip.cfeapps.com/api/user/generate_auth_cookie/?username=\(user)&password=\(password)")!)
        
        // Tipo de llamada
        request.httpMethod = "GET"
        
        // Hacemos la peticion al servicio
        session.dataTask(with: request) { (data, response, error) in
            // Gestionar lo que hemos recibido. Vamos a convertir el responde en un objeto HttpURLResponse para gestional el codigo de respuesta del servidor
            
            guard let data = data, error == nil, let respuesta = response as? HTTPURLResponse else {
                print("Ha ocurrido un error")
                return
            }
            
            // Comprobamos el codigo del servidor
            if respuesta.statusCode == 200 {
                // Gestionar el objeto que nos va a devolver el servidor
                do {
                    let decoder = JSONDecoder()
                    self.userModel = try decoder.decode(UserModel.self, from: data)
                    
                    if let user = self.userModel {
                        let userModel = UserModel(status: user.status, cookie: user.cookie, user: user.user)
                        completion(userModel)
                    }
                    // capturamos el token
                    self.requestToken(user: user, password: password)
                    
                } catch {
                    print("No se ha podido parsear el archivo causa, error: \(error.localizedDescription)")
                }
            
            } else if respuesta.statusCode == 404 {
                print("Error 404")
            }
            else {
                print("Ha habido un problema con el servidor \(respuesta.statusCode)")
            }
            
        }.resume()
    }
    
    func resetPassword(email: String, completion: @escaping (Bool) -> ()) {
        // CREAMOS LA SESION
        let session = URLSession.shared
        
        // Creamos la request con la url
        var request = URLRequest(url: URL(string: "https://www.mentoriavip.cfeapps.com/api/user/retrieve_password/?user_login=\(email)")!)
        
        // Tipo de llamada
        request.httpMethod = "GET"
        
        // Hacemos la peticion al servicio
        session.dataTask(with: request) { (data, response, error) in
            // Gestionar lo que hemos recibido. Vamos a convertir el responde en un objeto HttpURLResponse para gestional el codigo de respuesta del servidor
            
            guard let _ = data, error == nil, let respuesta = response as? HTTPURLResponse else {
                print("Ha ocurrido un error")
                return
            }
            
            // Comprobamos el codigo del servidor
            if respuesta.statusCode == 200 {
                // Gestionar el objeto que nos va a devolver el servidor
                
                completion(true)
            
            } else if respuesta.statusCode == 404 {
                completion(false)
            }
            else {
                completion(false)
                print("Ha habido un problema con el servidor \(respuesta.statusCode)")
            }
            
        }.resume()
    }
    
    func requestToken(user: String, password: String) {
        let session = URLSession.shared
        
        // Creamos la request con la url
        var request = URLRequest(url: URL(string: "https://www.mentoriavip.cfeapps.com/wp-json/jwt-auth/v1/token?username=\(user)&password=\(password)")!)
        
        // Tipo de llamada
        request.httpMethod = "POST"
        
        // Hacemos la peticion al servicio
        session.dataTask(with: request) { (data, response, error) in
            // Gestionar lo que hemos recibido. Vamos a convertir el responde en un objeto HttpURLResponse para gestional el codigo de respuesta del servidor
            
            guard let data = data, error == nil, let respuesta = response as? HTTPURLResponse else {
                print("Ha ocurrido un error")
                return
            }
            
            // Comprobamos el codigo del servidor
            if respuesta.statusCode == 200 {
                // Gestionar el objeto que nos va a devolver el servidor
                do {
                    let decoder = JSONDecoder()
                    self.authTokenModel = try decoder.decode(AuthToken.self, from: data)
                    
                    if let authToken = self.authTokenModel {
                        print("Estamos trayendo el token: \(authToken.token)")
                        ManagerUserDefaults.sharedInstance.saveAuthToken(key: "token", value: authToken.token)
                    }
                } catch {
                    print("No se ha podido parsear el archivo, error: \(error.localizedDescription)")
                }
                
            } else if respuesta.statusCode == 404 {
            }
            else {
                print("Ha habido un problema con el servidor pe \(respuesta.statusCode)")
            }
            
        }.resume()
    }
    
    func getIsSubscriptionActive(authToken: String, email: String, completion: @escaping (Bool) -> ()) {
        let session = URLSession.shared
        
        // Creamos la request con la url
        var request = URLRequest(url: URL(string: "https://www.mentoriavip.cfeapps.com/wp-json/rcp/v1/members/?s=\(email)")!)
        
        // Tipo de llamada
        request.httpMethod = "GET"
        let token = "ssdkjsfjdkfkdfjkdjfkdsfjkdsjflkfjrlrkejk"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // Hacemos la peticion al servicio
        session.dataTask(with: request) { (data, response, error) in
            // Gestionar lo que hemos recibido. Vamos a convertir el responde en un objeto HttpURLResponse para gestional el codigo de respuesta del servidor
            
            guard let data = data, error == nil, let respuesta = response as? HTTPURLResponse else {
                print("Ha ocurrido un error")
                return
            }
            
            // Comprobamos el codigo del servidor
            if respuesta.statusCode == 200 {
                
                do {
                    let decoder = JSONDecoder()
                    
                    self.subscriptionModel = try decoder.decode([SubscriptionModel].self, from: data)
                    
                    if let subscription = self.subscriptionModel {
                        
                        completion(subscription[0].isSubscriptionActive)
                    }
                    
                    
                } catch {
                        print("No se ha podido parsear el archivo")
                    }
            } else if respuesta.statusCode == 404 {
            }
            else {
                print("Ha habido un problema con el servidor pe \(respuesta.statusCode)")
            }
            
        }.resume()
    }
    
    func getIndiceData(completion: @escaping ([MenuModel]) -> ()) {
        let session = URLSession.shared
        
        // Creamos la request con la url
        var request = URLRequest(url: URL(string: "https://www.campusiosonline.com/indice.json")!)
        
        // Tipo de llamada
        request.httpMethod = "GET"
        let token = "ssdkjsfjdkfkdfjkdjfkdsfjkdsjflkfjrlrkejk"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // Hacemos la peticion al servicio
        session.dataTask(with: request) { (data, response, error) in
            // Gestionar lo que hemos recibido. Vamos a convertir el responde en un objeto HttpURLResponse para gestional el codigo de respuesta del servidor
            
            guard let data = data, error == nil, let respuesta = response as? HTTPURLResponse else {
                print("Ha ocurrido un error")
                return
            }
            
            // Comprobamos el codigo del servidor
            if respuesta.statusCode == 200 {
                
                do {
                    let decoder = JSONDecoder()
                    
                    self.menuModel = try decoder.decode([MenuModel].self, from: data)
                    if let indice = self.menuModel {
                        completion(indice)
                    }
                } catch {
                        print("No se ha podido parsear el archivo")
                    }
            } else if respuesta.statusCode == 404 {
            }
            else {
                print("Ha habido un problema con el servidor pe \(respuesta.statusCode)")
            }
            
        }.resume()
    }
}
