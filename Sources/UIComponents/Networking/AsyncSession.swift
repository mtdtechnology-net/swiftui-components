//
//  URLSessionExtension.swift
//
//
//  Created by Daniel Mandea on 25.06.2023.
//

import Foundation
import NetworkExtension

struct AsyncSession {
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    
    
}
