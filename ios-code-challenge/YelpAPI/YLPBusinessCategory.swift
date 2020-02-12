//
//  YLPBusinessCategory.swift
//  ios-code-challenge
//
//  Created by Clarissa Jawaid on 2/12/20.
//  Copyright © 2020 Dustin Lange. All rights reserved.
//

@objcMembers class YLPBusinessCategory: NSObject {
    let title: String
    let alias: String?
    
    public init(title: String, alias: String?) {
        self.title = title
        self.alias = alias
        super.init()
    }
}
