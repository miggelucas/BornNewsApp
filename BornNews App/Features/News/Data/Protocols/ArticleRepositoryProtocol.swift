//
//  ArticleRepositoryProtocol.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

protocol ArticleRepositoryProtocol {
    
    func getHeadlineGeneralArticles(country: CountryOption, page: Int) async -> Result<[Article], RemoteDataSourceError>
    
    func getHeadlineBusinessArticles(country: CountryOption, page: Int) async -> Result<[Article], RemoteDataSourceError>
    
    func getHeadlineEntertainmentArticles(country: CountryOption, page: Int) async -> Result<[Article], RemoteDataSourceError>
    
    func getHeadlineHealthArticles(country: CountryOption, page: Int) async -> Result<[Article], RemoteDataSourceError>
    
    func getHeadlineScienceArticles(country: CountryOption, page: Int) async -> Result<[Article], RemoteDataSourceError>
    
    func getHeadlineSportsArticles(country: CountryOption, page: Int) async -> Result<[Article], RemoteDataSourceError>
    
    func getHeadlineTechnologyArticles(country: CountryOption, page: Int) async -> Result<[Article], RemoteDataSourceError>
}
