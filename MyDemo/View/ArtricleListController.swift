//
//  ArtricleListController.swift
//  MyDemo
//
//  Created by 赵家琛 on 2017/11/13.
//  Copyright © 2017年 赵家琛. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import WMPageController
import MJRefresh
import SDWebImage


class ArticleListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var articles: [Article]? = []
    var newsTableView: UITableView!
    var type: Int = 1
    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView = UITableView(frame: self.view.bounds, style: .plain)
        newsTableView.register(ArticleCell.self, forCellReuseIdentifier: "Fuck You")
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.rowHeight = 150
        newsTableView.estimatedRowHeight = 150
        newsTableView.contentInset.bottom = 120
        self.view.addSubview(newsTableView)
        
//        newsTableView.contentInset = UIEdgeInsets(top: (self.navigationController?.navigationBar.bounds.size.height)! + UIApplication.shared.statusBarFrame.size.height + 36, left: 0, bottom: 49, right: 0)
//        newsTableView.scrollIndicatorInsets = UIEdgeInsets(top: (self.navigationController?.navigationBar.bounds.size.height)! + UIApplication.shared.statusBarFrame.size.height + 36, left: 0, bottom: 49, right: 0)
//
//        fetchArticles()
        
        //下拉刷新
        let header = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
        var refreshingImages = [UIImage]()
        for i in 1...6 {
            let img = UIImage(named: "鹿鹿\(i)的副本")?.reSizeImage(reSize: CGSize(width: 60, height: 60))
            refreshingImages.append(img!)
        }
        header?.setImages(refreshingImages, duration: 0.7, for: .pulling)
        header?.stateLabel.isHidden = true
        header?.lastUpdatedTimeLabel.isHidden = true
        
        //上拉加载
        //let footer = MJRefreshFooter(refreshingTarget: self, refreshingAction: #selector(nextPage))
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(nextPage))
        
        newsTableView.mj_header = header
        newsTableView.mj_header.beginRefreshing()
        
        newsTableView.mj_footer = footer
        newsTableView.mj_footer.isAutomaticallyHidden = true
        
    }
    
    @objc func refreshData() {
        print("ss")
        currentPage = 1
        fetchArticles()
    }
    
    @objc func nextPage() {
        print("aa")
        currentPage += 1
        fetchArticles()
    }
    
    func fetchArticles() {
        
        GetInformation.getNewsInformation(success: { dic in
            
            if let articlesFromJson = dic["data"] as? [[String : AnyObject]] {
                var newPage = [Article]()
                for articleFromJson in articlesFromJson {
                    var article = Article()
                    if
                        let title = articleFromJson["subject"] as? String,
                        let visit = articleFromJson["visitcount"] as? String,
                        let comment = articleFromJson["comments"] as? Int,
                        let desc = articleFromJson["summary"] as? String,
                        let url = articleFromJson["index"] as? String,
                        let urlToImage = articleFromJson["pic"] as? String {
                        article.visit = String(visit)
                        article.comment = String(comment)
                        article.detail = desc
                        article.title = title
                        article.url = "http://open.twtstudio.com/api/v1/news/" + String(url)
                        article.imgURL = urlToImage
                    }
                    //self.articles?.append(article)
                    newPage.append(article)
                }
                if self.currentPage == 1 {
                    self.articles = newPage
                } else {
                    if newPage.count == 0 {
                        self.currentPage -= 1
                        
                        let alert = UIAlertController(title: nil, message: "已到最后一页", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            self.presentedViewController?.dismiss(animated: true, completion: nil)
                        }
                        //self.newsTableView.mj_footer.endRefreshing()
                        
                    } else {
                        self.articles?.append(contentsOf: newPage)
                    }
                }
                self.newsTableView.reloadData()
                self.newsTableView.mj_header.endRefreshing()
                self.newsTableView.mj_footer.endRefreshing()
//                if self.newsTableView.mj_header.isRefreshing {
//                    self.newsTableView.mj_header.endRefreshing()
//                }
//                if self.newsTableView.mj_footer.isRefreshing {
//                    self.newsTableView.mj_footer.endRefreshing()
//                }
            }
        }, failure: { error in
//            if self.newsTableView.mj_header.isRefreshing {
//                self.newsTableView.mj_header.endRefreshing()
//            }
//            if self.newsTableView.mj_footer.isRefreshing {
//                self.newsTableView.mj_footer.endRefreshing()
//            }
            self.newsTableView.mj_header.endRefreshing()
            self.newsTableView.mj_footer.endRefreshing()
            print(error)
        }, type: type, page: currentPage)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Fuck You", for: indexPath) as! ArticleCell
        cell.titleLabel.text = self.articles?[indexPath.row].title
        cell.detailLabel.text = self.articles?[indexPath.row].detail
        cell.visitLabel.text = "访问数：" + (self.articles?[indexPath.row].visit!)!
        cell.commentLabel.text = "评论数：" + (self.articles?[indexPath.row].comment!)!
        cell.imgView.sd_setImage(with: URL(string: self.articles![indexPath.row].imgURL!), placeholderImage: UIImage(named: "蓝勾的副本.png"), options: .avoidAutoSetImage, completed: nil)
        //cell.imgView.downLoadImage(from: self.articles![indexPath.row].imgURL!)
        //print(self.articles?[indexPath.row].imgURL! ?? "fuck")
        return cell
        
    }
    
    
    
}

/**
 *重设图片大小
 */
extension UIImage {
    
    func reSizeImage(reSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        return newImage
        
    }
    
}


//获得图片
//extension UIImageView {
//
//    func downLoadImage(from url: String) {
//
//        let urlRequest = URLRequest(url: URL(string: url))
//
//        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if error != nil {
//                print(error)
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.image = UIImage(data: data!)
//            }
//
//        }
//        task.resume()
//
//    }
//
//
//}
