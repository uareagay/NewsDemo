//
//  ArticleMainController.swift
//  MyDemo
//
//  Created by 赵家琛 on 2017/11/13.
//  Copyright © 2017年 赵家琛. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import WMPageController

class ArticleMainController: WMPageController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("fuck you???")
        
    }
    
    convenience init?(para: Int) {
        
        self.init(viewControllerClasses: [ArticleListController.self, ArticleListController.self, ArticleListController.self, ArticleListController.self, ArticleListController.self], andTheirTitles: ["天大要闻", "校园公告", "社团风采", "院系动态", "视点观察"])
        self.title = "新闻"
        self.pageAnimatable = true
        self.menuViewStyle = .line
        self.menuItemWidth = 100

//        KVO Passing Value: Don't Know
//        self.values = ["1", "2", "3", "4", "5"]
//        self.keys = ["typ", "typ", "typ", "typ", "typ"]
        
        self.reloadData()
        
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        let childVC = ArticleListController()
        if index == 0 {
            childVC.type = 1
        } else if index == 1 {
            childVC.type = 2
        } else if index == 2 {
            childVC.type = 3
        } else if index == 3 {
            childVC.type = 4
        } else {
            childVC.type = 5
        }
        return childVC
        
    }
    
}

//extension ArticleMainController: WMPageControllerDelegate {
//    
//    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
//        
//    }
//    
//    
//    
//}




