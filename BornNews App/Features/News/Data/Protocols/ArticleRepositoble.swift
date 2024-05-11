//
//  ArticleRepositoble.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

protocol ArticleRepositoble {
    func getHeadlineArticles() async -> Result<[Article], Error>
    
}


