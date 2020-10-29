//
//  ResetPasswordViewController.swift
//  PeliculasApp
//
//  Created by michcode on 10/27/20.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    private let managerConnections = ManagerConnections()

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func didTapResetPassword(_ sender: Any) {
        guard
            let emailTxt = emailTextField.text,
            !emailTxt.isEmpty && validateEmail(email: emailTxt)
        else {
            showError()
            return
        }
        // La llamada al servicio para resetear la contraseña
        callResetPasswordWith(email: emailTxt)
    }
    
    private func callResetPasswordWith(email: String) {
        managerConnections.resetPassword(email: email) { (isChangePassword) in
            if isChangePassword {
                self.showResetPassword()
            }
        }
    }
    
    private func showResetPassword() {
        // ESTO SE TIENE QUE LLAMAR DENTRO DEL HILO PRINCIPAL
        DispatchQueue.main.async {
            self.alert(title: "Resetear contraseña", message: "Te hemos enviado un email para que puedas resetear tu contraseña.")
        }
    }
    private func showError() {
       alert(title: "Resetear contraseña", message: "Por favor, introduce un email válido.")
    }
    
    func validateEmail(email: String) -> Bool {
        let regex: String
        regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}
