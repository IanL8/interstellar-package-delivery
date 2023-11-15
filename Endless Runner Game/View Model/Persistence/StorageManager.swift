//
//  StorageManager.swift
//  Campus
//
//  Created by Ian Lommock on 10/3/22.
//

import Foundation

class StorageManager{
    
    var files : [String:FileInfo] = [:]
    
    func read<T:Codable>(from fileName : String, to data: inout T?){
        let fileInfo = FileInfo(file: fileName)
        
        files[fileName] = fileInfo
        
        if fileInfo.exists {
            let decoder = JSONDecoder()
            
            do {
                let d = try Data.init(contentsOf: fileInfo.url)
                data = try decoder.decode(T.self, from: d)
            } catch {
                print(error)
                data = nil
            }
            return
        }
        
        let mainBundle = Bundle.main
        let url = mainBundle.url(forResource: fileName, withExtension: "json")
        
        guard url != nil else {
            data = nil
            return
        }
        
        do {
            let d = try Data.init(contentsOf: url!)
            let decoder = JSONDecoder()
            data = try decoder.decode(T.self, from: d)
        } catch {
            print(error)
            data = nil
        }
    }
    
    func write<T:Codable>(to fileName : String, from data : T) {
        let encoder = JSONEncoder()
        do {
            let d = try encoder.encode(data)
            
            if let file = files[fileName] {
                try d.write(to: file.url)
            } else {
                try d.write(to: FileInfo(file: fileName).url)
            }
            
        } catch {
            print(error)
        }
    }
}
