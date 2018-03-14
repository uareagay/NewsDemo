//
//  ArticleCell.swift
//  MyDemo
//
//  Created by 赵家琛 on 2017/11/12.
//  Copyright © 2017年 赵家琛. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ArticleCell: UITableViewCell {
    
    var imgView: UIImageView!
    var authorLabel: UILabel!
    var titleLabel: UILabel!
    var detailLabel: UILabel!
    var visitLabel: UILabel!
    var commentLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgView = UIImageView()
        authorLabel = UILabel()
        detailLabel = UILabel()
        titleLabel = UILabel()
        visitLabel = UILabel()
        commentLabel = UILabel()
        
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(visitLabel)
        contentView.addSubview(commentLabel)
        
        //图片
        imgView.snp.makeConstraints { make in
            make.width.height.equalTo(110)
            make.bottom.equalTo(-20)
            make.left.equalTo(10)
        }
        
        //新闻标题
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.bottom.equalTo(-90)
            make.left.equalTo(130)
        }
        
        //新闻介绍
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFont(ofSize: 13)
        detailLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.left.equalTo(130)
            make.bottom.equalTo(-30)
        }
        
        //访问量
        visitLabel.font = UIFont.systemFont(ofSize: 11)
        visitLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(20)
            make.bottom.equalTo(0)
            make.right.equalTo(-160)
        }
        
        //评论数
        commentLabel.font = UIFont.systemFont(ofSize: 11)
        commentLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(20)
            make.bottom.equalTo(0)
            make.right.equalTo(-80)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Initialization code
    }
    
}
