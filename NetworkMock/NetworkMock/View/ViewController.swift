//
//  ViewController.swift
//  NetworkMock
//
//  Created by 강수진 on 2022/05/06.
//

import UIKit


class ViewController: UIViewController {
    
    // MARK: - properties
    
    var userGuideDescription: String? = "Welcome"
    private let networkManager: NetworkManager
    
    // MARK: - init
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: "ViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        networkManager = NetworkManager()
        super.init(coder: coder)
    }
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - func
    
    func getCoffees() {
        networkManager.fetchData(for: "https://api.sampleapis.com/coffee/hot",
                                  dataType: [Coffee].self) { [weak self] result in
            switch result {
            case .success(let coffees):
                self?.setUserGuide(to: "\(coffees.first?.title ?? "") 커피 나왔습니다")
            case .failure(_):
                self?.setUserGuide(to: "오류가 발생했습니다. 다시 시도해주세요")
            }
        }
    }
    
    private func setUserGuide(to description: String?) {
        userGuideDescription = description
    }
}
