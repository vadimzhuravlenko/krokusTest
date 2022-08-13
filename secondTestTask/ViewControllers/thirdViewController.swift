//
//  thirdViewController.swift
//  secondTestTask
//
//  Created by Vadim Zhuravlenko on 13.08.22.
//

import UIKit

class thirdViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    var text = ""
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textLabel.text = text
        imageView.image = image
        
    }
    

}
