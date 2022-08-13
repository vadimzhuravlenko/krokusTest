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
    var citiesDict = [Int:String]()
    var firstCityID: Int = 0
    var cityImage = [String:String]()
    var image: String = ""
    
    

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
            if json[index]["lang"] == 3 {
                let curr = ("\(json[index]["name"])")
                citiesDict[json[index]["id"].rawValue as! Int] = ("\(json[index]["name"])")
                citiesDict = citiesDict.filter ({ $0.value != ""})
                namesArray.append(curr)
                namesArray = namesArray.filter({ $0 != ""})
                cityImage[("\(json[index]["logo"])")] = ("\(json[index]["name"])")
                cityImage = cityImage.filter ({ $0.value != ""})
                    }
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
        for (key, value) in cityImage {
            if cell.textLabel?.text == value {
                image = key
            }
        }
        let url = NSURL(string:"\(image)")
            let imagedata = NSData.init(contentsOf: url! as URL)

        if imagedata != nil {
            cell.imageView?.image = UIImage(data:imagedata! as Data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
        let cell = tableView.cellForRow(at: indexPath)
        guard let cellText = cell?.textLabel?.text else { return }
//        print(cellText)
        for (key, value) in citiesDict {
            if cellText == value {
                firstCityID = key
            }
        }
        VC.secondCityID = firstCityID
        self.navigationController?.pushViewController(VC, animated: false)
        
        
    }
    
}

