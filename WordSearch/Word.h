//
//  KeyWord.h
//  CollectiveView
//
//  Created by user on 16/3/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject

@property (nonatomic, copy) NSString *english;
@property (nonatomic, copy) NSString *chinese;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, assign) NSInteger nIndex;

@end
