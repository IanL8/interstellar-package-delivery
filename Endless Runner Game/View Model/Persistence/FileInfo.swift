//
//  FileInfo.swift
//  Campus
//
//  Created by Ian Lommock on 10/3/22.
//

import Foundation

// from class
struct FileInfo {
    let name : String
    let url : URL
    let exists : Bool
    
    init(file filename: String) {
        name = filename
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url = documentURL.appendingPathComponent(filename + ".json")
        exists = fileManager.fileExists(atPath: url.path)
    }
}
