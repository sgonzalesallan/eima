//
//  FileManagerHelper.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import Foundation

class FileManagerHelper {
    
    static let shared = FileManagerHelper() // Singleton instance

    private init() {}

    func load<T: Decodable>(_ type: T.Type, from file: String) async throws -> T {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: file)) else {
            throw NSError(domain: "FileManagerHelper", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load data"])
        }

        return try JSONDecoder().decode(type, from: data)
    }

    func save<T: Encodable>(_ data: T, to file: String) async throws {
        print("saving file.... \(file)")
        let encodedData = try JSONEncoder().encode(data)
        try await encodedData.write(to: URL(fileURLWithPath: file))
    }

    func documentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func getJsonDataPath(fileName: String) -> String {
        return documentDirectory().appendingPathComponent(fileName).path
    }
}


