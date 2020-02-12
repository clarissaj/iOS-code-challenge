//
//  YLPBusiness.h
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

@import Foundation;
@import UIKit;
@class YLPBusinessCategory;

NS_ASSUME_NONNULL_BEGIN

@interface YLPBusiness : NSObject

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

/**
 *  Yelp id of this business.
 */
@property (nonatomic, readonly, copy) NSString *identifier;

/**
 *  Name of this business.
 */
@property (nonatomic, readonly, copy) NSString *name;

/**
* List of category title and alias pairs associated with this business.
*/
@property (nonatomic, readonly, copy) NSArray<YLPBusinessCategory*> *categories;

/**
*  Rating for this business.
*/
@property (nonatomic, readonly, copy) NSString *rating;

/**
*  Number of reviews for this business.
*/
@property (nonatomic, readonly, copy) NSString *reviewCount;

/**
*  Distance in meters from the search location.
*/
@property (nonatomic, readonly, copy) NSString *distance;

/**
*  Photo for this business.
*/
@property (nonatomic, readonly) UIImage *image;

/**
 *  Price level of the business.
 */
@property (nonatomic, readonly, copy) NSString *priceLevel;

@end

NS_ASSUME_NONNULL_END
