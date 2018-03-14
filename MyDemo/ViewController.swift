//
//  ViewController.swift
//  MyDemo
//
//  Created by 赵家琛 on 2017/11/11.
//  Copyright © 2017年 赵家琛. All rights reserved.
//

import UIKit
import WMPageController
import SDWebImage

class ViewController: UIViewController {

    var sb: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sb = UIImageView(frame: self.view.bounds)
        sb.sd_setImage(with: URL(string: "https://api.dujin.org/bing/1366.php")) { (_, _, _, _) in
            print("load")
        }
        self.view.addSubview(sb)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

