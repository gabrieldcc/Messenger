//
//  NewConversationViewController.swift
//  Messenger
//
//  Created by Gabriel de Castro Chaves on 17/06/23.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let searchBar: UISearchBar = {
        let component = UISearchBar()
        component.placeholder = "Search for Users..."
        return component
    }()
    
    private let tableView: UITableView = {
        let component = UITableView()
        component.isHidden = true
        component.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return component
    }()
    
    private let noResultsLabel: UILabel = {
        let component = UILabel()
        component.text = "No Results"
        component.textAlignment = .center
        component.textColor = .green
        component.font = .systemFont(ofSize: 21, weight: .medium)
        return component
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(dismissSelf))
        searchBar.becomeFirstResponder()
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true)
    }
}

extension NewConversationViewController: UISearchBarDelegate {
    
}
