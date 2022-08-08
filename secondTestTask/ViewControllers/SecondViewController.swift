//
//  SecondViewController.swift
//  secondTestTask
//
//  Created by Vadim Zhuravlenko on 8.08.22.
//

import UIKit
import Alamofire
import SwiftyJSON

class SecondViewController: UIViewController {

    let secondUrl = "http://krokapp.by/api/get_points/11/"
    var placesArray = [String]()
    
    @IBOutlet weak var secondTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        setUpTableView()
        
        
        
    }
    
    private func setUpTableView() {
        secondTable.delegate = self
        secondTable.dataSource = self
        secondTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func getData() {
        AF.request(secondUrl).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                self.update(json: json)
            

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                    }
            self.secondTable.reloadData()
        }
    }
    
    func update(json: JSON) {
        for index in 0...json.count-1 {
            let curr = ("\(json[index]["name"])")
            
            placesArray.append(curr)
                }

    }

}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return placesArray.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = secondTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = placesArray[indexPath.row]
        return cell
    }
    
}
