//
//  ProductListVC.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-26.
//

import UIKit

class ProductListVC: UIViewController {

    var productTblView = UITableView()
    var activityIndicator = UIActivityIndicatorView()
    static let productCell = "productCell"
    var viewModel: ProductViewModel = ProductViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        setUpSearchBar()
        configureTableView()
        configureActivityIndicator()
        initViewModel()
    }
    
    func configureTableView() {
        view.addSubview(productTblView)
        productTblView.rowHeight = 160
        productTblView.delegate = self
        productTblView.dataSource = self
        productTblView.register(ProductCell.self, forCellReuseIdentifier: ProductListVC.productCell)
        productTblView.pin(to: view)
    }
    
    func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        view.backgroundColor = .white
        activityIndicator.color = .systemBlue
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func initViewModel() {
        viewModel = ProductViewModel()
        viewModel.updatingStatus = { [weak self] () in
        DispatchQueue.main.async {
            let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2) {
                        self?.productTblView.alpha = 0
                        }
                    } else {
                        self!.activityIndicator.stopAnimating()
                        UIView.animate(withDuration: 0.2) {
                        self?.productTblView.alpha = 1.0
                    }
                }
            }
        }
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.productTblView.reloadData()
            }
        }
        viewModel.getApiData()
    }
    
    func setUpSearchBar() {
        searchController.searchBar.showsCancelButton = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Product Name,Sku, Keyword..."
        navigationItem.searchController = searchController
    }
}

// MARK: - SearchBar delegate
extension ProductListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchProduct(searchText: searchText)
        productTblView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ProductListVC: FavouriteProduct {
    func getIndexPath(cell: UITableViewCell) {
        guard let indexpath = productTblView.indexPath(for: cell) else { return }
        viewModel.updateFavouriteStatus(indexPath: indexpath, complete: { [weak self] in
            self?.productTblView.reloadRows(at: [indexpath], with: .none)
        })
    }
}
