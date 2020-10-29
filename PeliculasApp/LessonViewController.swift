//
//  LessonViewController.swift
//  PeliculasApp
//
//  Created by michcode on 10/29/20.
//

import UIKit
import WebKit

class LessonViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var tittleLesson: UILabel!
    @IBOutlet weak var descriptionLesson: UITextView!
    @IBOutlet weak var webita: WKWebView!
    
    var lesson: LessonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let lessonReceived = lesson else {return}
        showLessonDetail(lesson: lessonReceived)
        // Do any additional setup after loading the view.
    }
    
    private func showLessonDetail(lesson: LessonModel) {
        webita.navigationDelegate = self
        tittleLesson.text = lesson.title
        descriptionLesson.text = lesson.textVideo
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(webView)

        /*let embedHTML="<html><head><style type=\"text/css\">body {background-color: transparent;color: black;}</style><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes\"/></head><body style=\"margin:0\"><div><iframe src=\"//player.vimeo.com/video/\(lesson.urlVideo)?autoplay=1&amp;title=1&amp;byline=1&amp;portrait=0\" width=\"640\" height=\"360\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div></body></html>"
        let url = URL(string: "https://")!
        webita.loadHTMLString(embedHTML as String, baseURL:url )
        webita.contentMode = UIView.ContentMode.scaleAspectFit*/
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // cuando empieza a cargar la web
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // TERMINA DE CARGAR LA WEB
    }
}
