//
//  ViewController.swift
//  To Do List 2.1
//
//  Created by Vlad Klunduk on 14/10/2023.
//

import UIKit

class ViewController: UITableViewController {
    
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItems().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getItems()[indexPath.row].name
        return cell
    }

    @objc func addTapped(){
        let ac = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Save", style: .default){ [weak self] _ in
            guard let name = ac.textFields![0].text else { return }
            self?.viewModel.createItem(name)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(ac, animated: true)
    }
}

