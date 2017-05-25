//
//  SendDataWhenReachable.swift
//  SaveEventually
//
//  Created by Elliot Leibu on 25/5/17.
//  Copyright © 2017 elliotleibu. All rights reserved.
//

import UIKit

class SendDataWhenReachable: WhenReachable {
    let data: String
    
    init(data: String) {
        self.data = data
    }
    
    override func execute(_ successCompletionHandler: @escaping () -> Void, connectionErrorCompletionHandler: @escaping () -> Void, otherErrorCompletionHandler: @escaping () -> Void) {
        
        // code to send data to server
        //  call successCompletionHandler() if successful
        //  call connectionErrorCompletionHandler() if unsuccessful because of a connection error
        //  call otherErrorCompletionHandler() if another error occurs
        
        print("Data sent")
        successCompletionHandler()
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let data = decoder.decodeObject(forKey: "data") as? String
            else { return nil }
        self.init(
            data: data
        )
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(self.data, forKey: "data")
    }
}
