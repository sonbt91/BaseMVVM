//
//  TableViewExtension.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

open class CollectionViewCell: UICollectionViewCell {
    class open func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    open func cellIdentifier() -> String {
        return String(describing: self.classForCoder)
    }
    
    class open func registerFor(_ collectionView: UICollectionView) {
        collectionView.register(self.getNib(), forCellWithReuseIdentifier: self.cellIdentifier())
    }
    
    class open func dequeue(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> CollectionViewCell? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier(), for: indexPath) as? CollectionViewCell
    }
}

open class TableViewCell: UITableViewCell {
    class open func cellIdentifier() -> String {
        return  String(describing: self)
    }
    
    class open func registerFor(_ tableView: UITableView) {
        tableView.register(self.getNib(), forCellReuseIdentifier: self.cellIdentifier())
    }
    
    class open func dequeue(_ tableView: UITableView, _ indexPath: IndexPath) -> TableViewCell? {
        return tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier(), for: indexPath) as? TableViewCell
    }
    
    open var isSeparatorHidden: Bool {
        get {
            return self.separatorInset.right != 0
        }
        set {
            if newValue {
                self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
            } else {
                self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
    }
}
