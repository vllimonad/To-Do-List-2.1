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

    @objc private func addTapped(){
        let ac = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        ac.addAction(UIAlertAction(title: "Save", style: .default){ [weak self] _ in
            guard let name = ac.textFields![0].text, !name.isEmpty else { return }
            self?.viewModel.createItem(name)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipe = UISwipeActionsConfiguration(actions: [UIContextualAction(style: .destructive, title: "Delete", handler: { [weak self] _, _, _ in
            self?.deleteRow(indexPath: indexPath)
        }),UIContextualAction(style: .normal, title: "Edit", handler: { [weak self] _, _, _ in
            self?.editRow(indexPath: indexPath)
        })])
        return swipe
    }
    
    func deleteRow(indexPath: IndexPath) {
        let item = viewModel.getItems()[indexPath.row]
        viewModel.deleteItem(item)
        tableView.deleteRows(at: [indexPath], with: .right)
    }
    
    func editRow(indexPath: IndexPath) {
        let item = viewModel.getItems()[indexPath.row]
        let ac = UIAlertController(title: "Change Name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        ac.addAction(UIAlertAction(title: "Save", style: .default){ [weak self] _ in
            guard let name = ac.textFields![0].text, !name.isEmpty else { return }
            self?.viewModel.updateItem(item, newName: name)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        present(ac, animated: true)
    }
}

