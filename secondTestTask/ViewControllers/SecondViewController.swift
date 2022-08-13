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
    var textArray = [String]()
    var secondCityID: Int = 0
    var textDict = [String:String]()
    var text = ""
    var placesImage = [String:String]()
    var placeImage: String = ""
    
    @IBOutlet weak var secondTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        setUpTableView()
//        print(secondCityID)
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
                self.update(json: json)
            

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                    }
            self.secondTable.reloadData()
        }
    }
    
    func update(json: JSON) {
        for index in 0...json.count-1 {
            if json[index]["city_id"].rawValue as! Int == secondCityID {
                if json[index]["lang"] == 3 {
                    let text = ("\(json[index]["text"])")
                    let curr = ("\(json[index]["name"])")
                    let text2 = String(htmlEncodedString: text)
                    placesArray.append(curr)
                    placesArray = placesArray.filter({ $0 != ""})
                    textArray.append(text2!)
                    textArray = textArray.filter({ $0 != ""})
                    self.textDict[curr] = text2
                    placesImage[("\(json[index]["logo"])")] = ("\(json[index]["name"])")
                    placesImage = placesImage.filter ({ $0.value != ""})
                    }
                }
            
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
        for (key, value) in placesImage {
            if cell.textLabel?.text == value {
                placeImage = key
            }
        }
        let url = NSURL(string:"\(placeImage)")
            let imagedata = NSData.init(contentsOf: url! as URL)

        if imagedata != nil {
            cell.imageView?.image = UIImage(data:imagedata! as Data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "thirdVC") as! thirdViewController
        let cell = tableView.cellForRow(at: indexPath)
        guard let cellText = cell?.textLabel?.text else { return }
//        print(cellText)
        for (key, value) in textDict {
            if cellText == key {
                text = value
            }
        }
        VC.text = text
        VC.image = (cell?.imageView?.image)!
//        print(text)
        self.navigationController?.pushViewController(VC, animated: false)
        
        
    }
    
}

extension String {
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else { return nil }
        
        self.init(attributedString.string)
    }
}
