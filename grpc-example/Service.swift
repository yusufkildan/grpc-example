//
//  Service.swift
//  grpc-example
//
//  Created by Scorp on 9.10.2019.
//  Copyright © 2019 Scorp. All rights reserved.
//

import Foundation
import SwiftGRPC

class Servie {
     private static let client = NoteServiceServiceClient.init(address: "127.0.0.1:50051", secure: false)
    
    // MARK: - Methods
    
    static func listNotes(completionHandler: @escaping(NoteList?, CallResult?) -> Void) {
       _ = try? client.list(Empty(), completion: completionHandler)
    }
    
    static func insertNote(note: Note, completionHandler: @escaping(Note?, CallResult?) -> Void) {
        _ = try? client.insert(note, completion: completionHandler)
    }
    
    static func delete(noteId: String, completionHandler: @escaping(Empty?, CallResult) -> Void) {
        _ = try? client.delete(NoteRequestId(id: noteId), completion: completionHandler)
    }
    
    static func update(note: Note, completionHandler: @escaping(Note?, CallResult) -> Void) {
        _ = try? client.update(note, completion: completionHandler)
    }
}
