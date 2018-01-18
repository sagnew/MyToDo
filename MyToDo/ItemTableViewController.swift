//
//  ItemTableViewController.swift
//  MyToDo
//
//  Created by Angie Mugo on 17/01/2018.
//  Copyright © 2018 Angie Mugo. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    private var todoList = [ToDoItem]()
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configureView()
    }

    func configureView() {

        //Only display the cells with content
        tableView.tableFooterView = UIView(frame: .zero)

        //Add color gradient to the view
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.tableView.bounds
        gradientLayer.colors = [UIColor.red.withAlphaComponent(5).cgColor,UIColor.yellow.withAlphaComponent(0.5).cgColor]
        let backgroundView = UIView(frame: self.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        self.tableView.backgroundView = backgroundView

    }

    //MARK: IBActions

    @IBAction func didTapAdd(_ sender: Any) {

        let alert = UIAlertController(title: "New To-Do Item", message: "Insert the title of the new to-do item:", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in

            if let title = alert.textFields![0].text {
                guard !title.isEmpty else { return }
                self.addNewToDoItem(title: title)
            }

        }))

        self.present(alert, animated: true, completion: nil)

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList .count
    }

    // MARK: - Table view delegate methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.clear

        if indexPath.row < todoList.count
        {
            let item = todoList[indexPath.row]
            cell.textLabel?.text = item.title
            
            //MARK: set the checkmark for item done
            let accessory: UITableViewCellAccessoryType = item.done ? .checkmark : .none
            cell.accessoryType = accessory
        }

        return cell
    }

    //MARK: mark as done

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < todoList.count {

            todoList[indexPath.row].done = !todoList[indexPath.row].done

            tableView.reloadRows(at: [indexPath], with: .automatic)

            saveData()
        }
    }

    //MARK: delete items

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if indexPath.row < todoList.count {

            todoList.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .top)
            saveData()
        }
    }
    
    //MARK: add item

    private func addNewToDoItem(title: String) {
        
        let newIndex = todoList.count
        todoList.append(ToDoItem(title: title))

        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)

        saveData()
    }
    
    //MARK: fetch data from user defaults

    func fetchData() {
        
        if let list = defaults.value(forKey: "encodedList") as? [[String: Any]] {
            
            for item in list {
                guard let todoItem = ToDoItem(item) else { return }
                todoList.append(todoItem)
            }
        }
    }
    
    
    //MARK: Save data to user defaults
    
    func saveData() {
        
        var encodedList = [[String: Any]]()
        
        for item in todoList {
            encodedList.append(item.toPropertyList())
        }

        defaults.set(encodedList, forKey: "encodedList")
    }
    
}
