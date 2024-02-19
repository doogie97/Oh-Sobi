//
//  HomeVC.swift
//  Oh-Sobi
//
//  Created by Doogie on 11/16/23.
//

import UIKit
import RxSwift

class HomeVC: UIViewController {
    private let viewModel: HomeVMable
    private let homeView = HomeView()
    private let disposeBag = DisposeBag()
    
    init(viewModel: HomeVMable) {
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
        bindViewModel()
        viewModel.getInitialHomeInfo()
    }
    
    private func bindViewModel() {
        viewModel.setViewContents.withUnretained(self)
            .subscribe(onNext: { owner, viewContents in
                owner.homeView.setViewContents(viewContents: viewContents)
            })
            .disposed(by: disposeBag)
    }
}

