//
//  WhenReachable.swift
//  SaveEventually
//
//  Created by Elliot Leibu on 25/5/17.
//  Copyright © 2017 elliotleibu. All rights reserved.
//

import UIKit

class WhenReachable: NSObject, NSCoding {
    func execute(_ successCompletionHandler: @escaping () -> Void, connectionErrorCompletionHandler: @escaping () -> Void, otherErrorCompletionHandler: @escaping () -> Void) {
    }
    
    required convenience init?(coder decoder: NSCoder) {
        self.init(
        )
    }
    
    func encode(with coder: NSCoder) {
    }
}
