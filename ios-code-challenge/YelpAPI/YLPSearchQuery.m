//
//  YLPSearchQuery.m
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import "YLPSearchQuery.h"

@interface YLPSearchQuery()

@property (nonatomic, copy) NSString *location;

@end

@implementation YLPSearchQuery

- (instancetype)initWithLocation:(NSString *)location
{
    if(self = [super init]) {
        _location = location;
    }
    
    return self;
}
- (NSDictionary *)parameters
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if(self.location) {
        params[@"location"] = self.location;
    } else if(self.coordinates) {
        params[@"latitude"] = [NSString stringWithFormat:@"%f", self.coordinates.coordinate.latitude];
        params[@"longitude"] = [NSString stringWithFormat:@"%f", self.coordinates.coordinate.longitude];
    }
    
    if(self.term) {
        params[@"term"] = self.term;
    }
    
    if(self.radiusFilter > 0) {
        params[@"radius"] = @(self.radiusFilter);
    }
    
    if(self.categoryFilter != nil && self.categoryFilter.count > 0) {
        params[@"categories"] = [self.categoryFilter componentsJoinedByString:@","];
    }
    
    return params;
}

- (NSArray<NSString *> *)categoryFilter {
    return _categoryFilter ?: @[];
}

@end
