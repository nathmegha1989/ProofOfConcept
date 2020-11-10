//
//  FactListViewController.swift
//  ProofOfConcept
//
//  Created by administrator on 09/11/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit

class FactListViewController: UIViewController {
  let factsTableView = UITableView()
  var safeArea: UILayoutGuide!
  let dataSource = FactListViewDataSource()
  let refreshControl = UIRefreshControl()

  lazy var viewModel : FactListViewModel = {
      let viewModel = FactListViewModel(dataSource: dataSource)
      return viewModel
  }()

    override func viewDidLoad() {
      super.viewDidLoad()
        // Do any additional setup after loading the view.
      view.backgroundColor = .white
      viewModel.navigationItem = navigationItem
      safeArea = view.layoutMarginsGuide
      setupTableView()
      self.viewModel.onErrorHandling = { [weak self] error in
          // display error ?
          let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
          controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
          self?.present(controller, animated: true, completion: nil)
      }
      
      self.viewModel.fetchFacts()

    }
  
    func setupTableView() {
      view.addSubview(factsTableView)
      factsTableView.translatesAutoresizingMaskIntoConstraints = false
      factsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
      factsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      factsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      factsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
      
      factsTableView.register(FactListViewCell.self, forCellReuseIdentifier: "factListViewCell")
      factsTableView.dataSource = self.dataSource
      factsTableView.estimatedRowHeight = 100
      factsTableView.rowHeight = UITableView.automaticDimension
      self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
          self?.factsTableView.reloadData()
      }
      factsTableView.refreshControl = refreshControl
      viewModel.refreshControl = refreshControl
      refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

  }
  
  @objc private func refreshData(_ sender: Any) {
    self.viewModel.fetchFacts()
  }

  
}

