//
//  MasterViewController.swift
//  NYTimes
//
//  Created by Paurush on 28/06/19.
//  Copyright © 2019 Paurush. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    let viewModel = NYCViewModel()
    var isSearchEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        // Request for NYC data
        setUpData()
        setUpView()
        setUpNavBar()
    }
    
    fileprivate func setUpNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Most Popular News"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    private func setUpView() {
        self.title = "NY Times Popular"
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setUpData() {
        NYCLoader.shared.showProgressView()
        viewModel.requestForNYCArticles {
            DispatchQueue.main.async {
                NYCLoader.shared.hideProgressView()
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = viewModel.nycModel[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.nycModel = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchEnabled ? viewModel.filteredNews.count : viewModel.nycModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYCMasterCell", for: indexPath) as? NYCMasterCell
        let model = isSearchEnabled ? viewModel.filteredNews[indexPath.row] : viewModel.nycModel[indexPath.row]
        cell?.contentView.alpha = 0.0
        cell?.nycModel = model
        cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.8, animations: {
            cell.contentView.alpha = 1.0
        })
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
        let searchText = searchController.searchBar.text!
        if searchText.isEmpty {
            isSearchEnabled = false
        } else {
            isSearchEnabled = true
            self.viewModel.filteredNewsAccToSearch(text: searchText)
        }
        self.tableView.reloadData()
    }
}
