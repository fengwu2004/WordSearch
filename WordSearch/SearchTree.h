//
//  TNodeCreate.h
//  CollectiveView
//
//  Created by user on 16/3/21.
//  Copyright © 2016年 user. All rights reserved.
//

//
//trie树的优化，多一张26个字母的表alphabetMap
//

#import <Foundation/Foundation.h>

@interface SearchTree : NSObject

@property(nonatomic, retain) NSMutableDictionary *alphabetMap;

+ (SearchTree*)sharedInstance;

- (NSArray*)find:(NSString*)word;

- (void)create;

@end
