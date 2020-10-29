//
//  Extensions.swift
//  PeliculasApp
//
//  Created by michcode on 10/27/20.
//

import UIKit

extension UIViewController {
    
    // Aqui podemos crear funciones que pueden ser usadas por un controldor de vista
    func alert(title: String = "", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let buttonController = UIAlertAction(title: "Aceptar", style: .default) { action in
            // Podria jugar con esa accion: abrir una ventana, guardar cierto tado, llamar a un servicio
        }
        
        alertController.addAction(buttonController)
        present(alertController, animated: true) {
            // lo que quisiera
        }
    }
    
    // Poner titulo al navigation view controller
    func setTitleHeader(title: String) {
        navigationItem.title = title
    }
    
    func hiddenKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension Bundle {
    // Decoders one object type from a JSON filename stored in our bundle
    func decode<T: Decodable>(_ type: T.Type, from filename: String) -> T {
        guard let json = url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in app bundle.")
        }
        
        guard let jsonData = try? Data(contentsOf: json) else {
            fatalError("Failed to load \(filename) from app bundle.")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let result = try? decoder.decode(T.self, from: jsonData) else {
            fatalError("Failed to decode \(filename) from app bundle.")
        }
        
        return result
    }
}
