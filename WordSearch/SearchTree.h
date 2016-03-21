//
//  TNodeCreate.h
//  CollectiveView
//
//  Created by user on 16/3/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchTree : NSObject

@property(nonatomic, retain) NSMutableDictionary *alphabetMap;

+ (SearchTree*)sharedInstance;

- (NSArray*)find:(NSString*)word;

@end
