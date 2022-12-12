//
//  ViewController.swift
//  3mes7homework
//
//  Created by Нуридин Сафаралиев on 12/12/22.
//

import UIKit

class ViewController: UIViewController {

    
    
    var adresses = ["5 Микрорайон 46 дом", "Ибраимова 64", "Проспект Чуй", "Жукеева - Пудовкина 43", "Токтогула 99", "Моссовет  KFC", "Проспект Чуй", "Проспект Чуй", "Проспект Чуй"]
    var searchBarResults = [String]()
    var choosenAdresses: [String] = []
    
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searhcBarTableView: UITableView!
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarResults = adresses
        searhcBarTableView.register(UITableViewCell.self, forCellReuseIdentifier: "adress_cell")
        resultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "results_cell")
    }

    @IBAction func zakazatButton(_ sender: Any) {
        
        var price: Int {
            resultsTableView.numberOfRows(inSection: 0) * 100
        }
        
        let alert = UIAlertController(title: "Хотите заказать? ", message: "Стоимость будет состовять \(price) сом", preferredStyle: .alert)
        
        let actionYes = UIAlertAction(title: "Да", style: .default) { UIAlertAction in
        }
        
        let actionNO = UIAlertAction(title: "Нет", style: .destructive) { UIAlertAction in
        }
        
        alert.addAction(actionNO)
        alert.addAction(actionYes)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searhcBarTableView{
            return searchBarResults.count
        } else {
            return choosenAdresses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == searhcBarTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "adress_cell", for: indexPath)
            cell.textLabel?.text = searchBarResults[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "results_cell", for: indexPath)
            cell.textLabel?.text = choosenAdresses[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searhcBarTableView{
            choosenAdresses.append(tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "")
            resultsTableView.reloadData()
        }
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarResults = []
        
        if searchText != "" {
            for adres in adresses {
                if adres.uppercased().contains(searchText.uppercased()) {
                    searchBarResults.append(adres)
                    searhcBarTableView.reloadData()
                }
            }
        } else {
          searchBarResults = adresses
        }
    }
}
