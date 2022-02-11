//
//  Decoder.swift
//  GenshinDigits (iOS)
//
//  Created by Nikita Semenov on 03.02.2022.
//

import Foundation

enum DecodingFatalError: String {
    case decodingError = "Invalid JSON"
    case invalidURL = "Inavlid URL"
}

func checkDecodingForErrors<T: Decodable>(decoding d: @escaping () throws -> T) -> T {
    do {
        return try d()
    } catch is DecodingError {
        fatalError(DecodingFatalError.decodingError.rawValue)
    } catch {
        fatalError(DecodingFatalError.invalidURL.rawValue)
    }
}

func getContentsOfFile(atPath path: URL) throws -> Data {
    return try Data(contentsOf: path)
}

func decodeData<T: Decodable>(_ data: Data) throws -> T {
    let decoder = JSONDecoder()
    let content = try decoder.decode(T.self, from: data)
    return content
}
