//
//  ArticleDetailComponentProtocol.swift
//  BornNews App
//
//  Created by Lucas Migge on 16/05/24.
//

import UIKit

protocol ArticleDetailComponentView {
    var view: UIView { get }
    
    func configure(with article: Article)
}
