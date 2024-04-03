//
//  SettingsViewController.swift
//  TestApp
//
//  Created by Ivan Sadovich on 2.04.24.
//
import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView = UITableView()

    var developerName: String?
    var numberOfRows = 1 // Изначально одна ячейка

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Настройка таблицы
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // Создаем ячейку для кнопки "Об приложении"
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = "About the app (tap for creating)"
            return cell
        } else if indexPath.row == 1 && developerName != nil {
            // Создаем ячейку для имени разработчика
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = developerName
            return cell
        } else {
            // Создаем пустую ячейку
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // Добавляем новую ячейку с именем разработчика
            developerName = "Developer name"
            numberOfRows += 1
            tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            tableView.reloadData()

            // Открываем модальное окно с именем разработчика
            let alertController = UIAlertController(title: "Name", message: developerName, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}

