//
//  HomeViewController.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import UIKit
class HomeViewController: AbstractViewController<HomeViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    final fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.alpha = 0.0
        tableView.refreshControlHandler { [weak self] refresh in
            self?.loadData()
        }
    }
    
    final fileprivate func loadData() {
        requestData(page: 1)
    }
    
    final fileprivate func requestData(showLoading: Bool = true, page: Int? = nil) {
        // Loading data
        if showLoading {
            tableView.activityIndicatorView.startAnimating()
            
        }
        vm.fetchData(page: page) { [weak self] (result) in
            if showLoading {
                self?.tableView.refreshControl?.endRefreshing()
                self?.tableView.activityIndicatorView.stopAnimating()
            }
            switch result {
            case .success(let paginationResult):
                switch paginationResult {
                case .newData:
                    self?.updateUI()
                case .insertData(let newIndexs):
                    self?.tableView.beginUpdates()
                    self?.tableView.insertRows(at: newIndexs, with: .none)
                    self?.tableView.endUpdates()
                default:
                    break
                }
            case .failure(let error):
                self?.onError(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController {
            vc.beer = vm.getDetail()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PunkBeerTableViewCell.self), for: indexPath) as? PunkBeerTableViewCell else {
            return UITableViewCell()
        }
        let viewModelCell = vm.getDataFor(indexPath: indexPath)
        cell.contructWith(viewModel: viewModelCell)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.select(index: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetailSegue", sender: nil)
        
    }
}

extension HomeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tagertContentOffSet = (tableView.contentSize.height - tableView.frame.height)
        if scrollView.contentOffset.y >= tagertContentOffSet {
            requestData(showLoading: false)
        }
    }
}

extension HomeViewController {
    func onError(_ error: Error) {
        print(error)
        alert(message: error.localizedDescription, title: "Ops...")
    }
    
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            UIView.animate(withDuration: 0.5) {
                self?.tableView.alpha = 1.0
            }
        }
    }
}
