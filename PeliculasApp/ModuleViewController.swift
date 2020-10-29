//
//  MuduleViewController.swift
//  PeliculasApp
//
//  Created by michcode on 10/29/20.
//

import UIKit

class ModuleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    

    private var modules = [ModuleModel]()
    var dataChapter: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()

        // Do any additional setup after loading the view.
    }
    
    private func getData() {
        guard let chapter = dataChapter else {return}
        modules = Bundle.main.decode([ModuleModel].self, from: "\(chapter).json")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modules.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "lessonView") as! LessonViewController
        
        let lessonSelected = LessonModel(title: modules[indexPath.row].title, textVideo: modules[indexPath.row].textVideo, urlVideo: modules[indexPath.row].urlVideo)
        controller.lesson = lessonSelected
        controller.modalPresentationStyle = .fullScreen
        show(controller, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = modules[indexPath.row].title
        cell.detailTextLabel?.text = modules[indexPath.row].subtitle
        
        return cell
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
