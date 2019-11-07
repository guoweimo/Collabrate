//
//  HomeViewController.swift
//  Collabrate
//
//  Created by Guowei Mo on 21/10/2019.
//  Copyright © 2019 Guowei Mo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  private let tableView = UITableView()
  
  private lazy var headerView: UIView = {
    let label = UILabel()
    label.text = "最新热门"
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addFillingSubview(tableView)
    tableView.tableHeaderView = headerView
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(Cell: PostItemViewCell.self)
  }
  
  
}

extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
  }
}

extension HomeViewController: UITableViewDelegate {
  
}
