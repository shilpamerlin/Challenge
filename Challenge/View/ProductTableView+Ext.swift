//
//  ProductTableView+Ext.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-27.
//

import Foundation
import UIKit
import SDWebImage

// MARK: - UITableViewDataSource
extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCellModels
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListVC.productCell) as! ProductCell 
        let cellModel = viewModel.getCellAtRow(indexPath: indexPath)
        cell.contentView.isUserInteractionEnabled = false
        cell.configureProductCell(cellModel: cellModel)
        cell.delegate = self
        return cell
    }
}
