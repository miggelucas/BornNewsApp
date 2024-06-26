//
//  RemoteDataSourceError.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

enum RemoteDataSourceError: Error {
    case serverError, badRequest, failedToFetch, noMoreData
}
