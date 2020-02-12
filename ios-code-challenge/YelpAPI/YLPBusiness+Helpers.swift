//
//  YLPBusiness+Helpers.swift
//  ios-code-challenge
//
//  Created by Clarissa Jawaid on 2/12/20.
//  Copyright © 2020 Dustin Lange. All rights reserved.
//

extension YLPBusiness {
    
    @objc func getCategoriesAsString() -> String {
        var result = ""
        categories.forEach({ result += "\($0.title), " })
        if result != "" {
            result = String(result.dropLast(2))
        }
        return result
    }
    
    @objc func mapCategories(categories: [[String: String]]) -> [YLPBusinessCategory] {
        var converted: [YLPBusinessCategory] = []
        
        categories.forEach { category in
            if let title = category["title"] {
                converted.append(YLPBusinessCategory(title: title, alias: category["alias"]))
            }
        }
        
        return converted
    }
}
