//
//  ViewController.swift
//  PeliculasApp
//
//  Created by michcode on 10/22/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var userTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var restorePasswordButton: UIButton!
    
    private let managerConnections = ManagerConnections()
    
    // CLICLO DE VIDA DE LA VISTA
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    fileprivate func configureView() {
        hiddenKeyboard()
    }

    @IBAction private func didTapedLoginButton(_ sender: Any) {
        
        guard
            let username = userTextField.text,
            let password = passwordTextField.text,
            !username.isEmpty && !password.isEmpty else {
            showError()
            return
        }
        
        managerConnections.callLoginWith(user: username, password: password) { modelUser in
            
            DispatchQueue.main.async {
                self.showHomeViewController(with: modelUser)
            }
        }
    }
    
    private func showHomeViewController(with model: UserModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "homeView") as! HomeViewController
        controller.name = model.user.username
        controller.email = model.user.email
        controller.modalPresentationStyle = .fullScreen
        show(controller, sender: nil)
    }
    
    private func showError() {
       alert(title: "Mentoría Vip", message: "Por favor, introduzca un nombre de usuario y contraseña")
    }
    
    @IBAction private func restorePassword(_ sender: Any) {
    }

}

