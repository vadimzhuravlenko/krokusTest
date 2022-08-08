//
//  ViewController.swift
//  secondTestTask
//
//  Created by Vadim Zhuravlenko on 4.08.22.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    private var secondViewController: SecondViewController?
    var namesArray = [String]()
    let url = "https://krokapp.by/api/get_cities/11/"

    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        setUpTableView()

    }
    private func setUpTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func getData() {
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                self.update(json: json)
            

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                    }
            self.table.reloadData()
        }
    }
    
    func update(json: JSON) {
        for index in 0...json.count-1 {
            let curr = ("\(json[index]["name"])")
            namesArray.append(curr)
                }
    }
}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return namesArray.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = namesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
        self.navigationController?.pushViewController(VC, animated: false)
    }
    
}
