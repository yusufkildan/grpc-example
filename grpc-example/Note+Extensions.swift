//
//  Note+Extensions.swift
//  grpc-example
//
//  Created by Scorp on 9.10.2019.
//  Copyright © 2019 Scorp. All rights reserved.
//

import Foundation

extension Note {
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

extension NoteRequestId {
    
    init(id: String) {
        self.id = id
    }
}
