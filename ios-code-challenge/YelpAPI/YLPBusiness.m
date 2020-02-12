//
//  YLPBusiness.m
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import "YLPBusiness.h"

@implementation YLPBusiness

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    if(self = [super init]) {
        _identifier = attributes[@"id"];
        _name = attributes[@"name"];
        _categories = attributes[@"categories"];
        _rating = [NSString stringWithFormat:@"%@", attributes[@"rating"]];
        _reviewCount = [NSString stringWithFormat:@"%@", attributes[@"review_count"]];
        
        double distance = ((NSString*)attributes[@"distance"]).doubleValue;
        _distance = [NSString stringWithFormat:@"%.0f", distance];
        
        NSURL *imageURL = [NSURL URLWithString:attributes[@"image_url"]];
        NSData *imagedata = [NSData dataWithContentsOfURL:imageURL];
        _image = [UIImage imageWithData:imagedata];
    }
    
    return self;
}

@end
