//
//  CustomButton.swift
//  PeliculasApp
//
//  Created by michcode on 10/26/20.
//

import UIKit

class CustomButton: UIButton {
    
    // Inicializar el objeto con una serie de propiedades
    override func awakeFromNib() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        backgroundColor = UIColor.orange
        setTitleColor(.white, for: .normal)
    }
}
