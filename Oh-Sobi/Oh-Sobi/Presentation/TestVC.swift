//
//  TestVC.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/23/24.
//

import UIKit
import SnapKit

final class TestVC: UIViewController, UITableViewDataSource {
    private var scrollView: ZoomableView?
    private func setZoomableView() {
        self.view.backgroundColor = .white
        self.scrollView = ZoomableView(contentsView: testTV, contentsViewHeight: 2000)
        guard let scrollView = self.scrollView else {
            return
        }
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setZoomableView()
    }
    
    private lazy var testTV = {
        let tableView = UITableView()
        tableView.register(testCell.self, forCellReuseIdentifier: "\(testCell.self)")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(testCell.self)", for: indexPath) as? testCell else {
            return UITableViewCell()
        }
        
        cell.setCell(index: indexPath.row, height: 200)
        
        return cell
    }
}

final class testCell: UITableViewCell {
    let view = UIView()
    lazy var label = pretendardLabel(family: .Bold, size: 70, textAlignment: .center)
    func setCell(index: Int, height: Int) {
        label.text = (index + height).description
        self.selectionStyle = .none
        self.backgroundColor = index % 2 == 0 ? .systemBlue : .systemOrange
        self.contentView.addSubview(view)
        self.contentView.addSubview(label)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(height)
        }
        
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.label.text = nil
    }
}





final class ZoomableView: UIView, UIScrollViewDelegate {
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        
        return scrollView
    }()
    
    private let contentsView: UIView
    
    private var contentsViewHeight: CGFloat?
    
    init(contentsView: UIView, contentsViewHeight: CGFloat? = nil) {
        self.contentsView = contentsView
        self.contentsViewHeight = contentsViewHeight
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        contentsView.gestureRecognizers?.forEach { contentsView.removeGestureRecognizer($0) }
        self.addSubview(scrollView)
        scrollView.addSubview(contentsView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints {
            $0.top.bottom.width.equalToSuperview()
            if let contentsViewHeight = contentsViewHeight {
                $0.height.equalTo(contentsViewHeight)
            }
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentsView
    }
}
