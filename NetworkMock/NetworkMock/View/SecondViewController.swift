//
//  SecondViewController.swift
//  NetworkMock
//
//  Created by 강수진 on 2022/05/06.
//

import UIKit

class SecondViewController: UIViewController {
    
    var viewModel = SecondViewControllerViewModel(networkManager: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
