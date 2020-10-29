//
//  HomeViewController.swift
//  PeliculasApp
//
//  Created by michcode on 10/27/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var tablita: UITableView!
    
    private let managerConnections = ManagerConnections()
    
    var name: String? = nil
    var email: String? = nil
    
    var menu = [MenuModel]()
    
    private var isActiveSubscription: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        isSubscriptionActive()
        getData()
    }
    
    private func  getData() {
        // menu = Bundle.main.decode([MenuModel].self, from: "indice.json")
        managerConnections.getIndiceData { (indice) in
            self.menu = indice
            DispatchQueue.main.async {
                self.tablita.reloadData()
            }
        }
    }
    
    private func isSubscriptionActive() {
        let token = ManagerUserDefaults.sharedInstance.retrieveToken(key: "token")
        guard let emailReceived = email else {return}
        managerConnections.getIsSubscriptionActive(authToken: token, email: emailReceived) { (isSubscriptionActive) in
            self.isActiveSubscription = isSubscriptionActive
        }
    }

    private func configureView() {
        guard let nameReceived = name else {return}
        descriptionLabel.text = "Hola \(nameReceived), bienvenido a Campus iOS Online, selecciona el modulo que quieres visualizar."
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = menu[indexPath.row].title
        cell.detailTextLabel?.text = menu[indexPath.row].subtitle
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !isActiveSubscription {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "moduleView") as! ModuleViewController
        controller.dataChapter = menu[indexPath.row].chapter
        controller.modalPresentationStyle = .fullScreen
        show(controller, sender: nil)
        } else {
            alert(title: "Mentoria Vip", message: "Tienes que tener una subscripcion activa para ver este contenido. Consigue tu subscripcion en Htppt...,.")
        }
    }
}
