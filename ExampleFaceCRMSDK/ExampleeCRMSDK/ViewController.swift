//
//  ViewController.swift
//  ExampleeCRMSDK
//
//  Created by Thompson Michael on 6/11/19.
//  Copyright © 2019 Thompson Michael. All rights reserved.
//

import UIKit
import FaceCRM

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FaceCRM.shared.stopCamera()
    }


}

