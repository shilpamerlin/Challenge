//
//  ProductViewModel.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-26.
//

import Foundation

class ProductViewModel {
    
    // MARK: - Properties
    var products: [Products] = []
    var reloadTableViewClosure: (() -> Void) = {}
    var updatingStatus: (() -> Void) = {}
    private var filteredArray = [ProductCellModel]()
    private var productArray = [ProductCellModel]()
    var dataManager: DataManager
    private var cellViewModels = [ProductCellModel]() {
        didSet {
            self.reloadTableViewClosure()
        }
    }
    var numberOfCellModels: Int {
        return cellViewModels.count
    }
    var isLoading: Bool = false {
        didSet {
            updatingStatus()
        }
    }
    func getCellAtRow(indexPath: IndexPath) -> ProductCellModel {
        return cellViewModels[indexPath.row]
    }
   init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
    }
    func getApiData() {
        self.isLoading = true
        dataManager.fetchProducts { items in
            self.products = items
            self.processFetchedData(products: items)
            self.isLoading = false
        }
    }
    func processFetchedData(products: [Products]) {
        var cellModel = [ProductCellModel]()
        for product in products {
            let model = ProductCellModel(with: product)
            cellModel.append(model)
        }
        self.cellViewModels = cellModel
        self.productArray = cellViewModels
    }
    func searchProduct(searchText: String) {
        let searchString = searchText.lowercased()
        if searchText == "" {
            if filteredArray.count != 0 {
                self.cellViewModels = self.filteredArray
            } else {
                self.cellViewModels = productArray
            }
        } else {
            if  filteredArray.count !=  0 {
                self.cellViewModels = self.filteredArray.filter({$0.title!.lowercased().contains(searchString)})
            } else {
                self.cellViewModels = productArray.filter({$0.title!.lowercased().contains(searchString)})
            }
        }
    }
    public func updateFavouriteStatus(indexPath: IndexPath, complete: (() -> Void)) {
        cellViewModels[indexPath.row].isFavourite = !cellViewModels[indexPath.row].isFavourite!
        let favValue = cellViewModels[indexPath.row].isFavourite
        dataManager.makeProductFavorite(isFav: !(favValue)!)
        complete()
        
    }
}
