//
//  HomeVC.swift
//  Oh-Sobi
//
//  Created by Doogie on 11/16/23.
//

import UIKit

class HomeVC: UIViewController {
    private weak var viewModel: HomeVMable?
    private let homeView = HomeView()
    
    init(viewModel: HomeVMable?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        homeView.backgroundColor = .systemBackground
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeView.setViewContents()
    }
}

