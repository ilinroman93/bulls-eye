//
//  AboutVC.swift
//  bulls-eye
//
//  Created by Ильин Роман on 17.02.2018.
//  Copyright © 2018 Romax. All rights reserved.
//

import UIKit
import WebKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            if let htmlData = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
    }

    @IBAction func closeBtnPressed() {
        dismiss(animated: true, completion: nil)
    }

}
