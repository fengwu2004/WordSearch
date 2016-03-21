//
//  TNode.m
//  CollectiveView
//
//  Created by ky on 16/3/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TNode.h"
#import "SearchTree.h"

#define str1 @"virtualcalbald"
#define str2 @"heading"
#define str3 @"mechanical"

@implementation TNode

- (id)init {
	
	self = [super init];
	
	_subNodes = [[NSMutableArray alloc] init];
	
	return self;
}

- (id)initWithKey:(NSString*)key {
	
	self = [super init];
	
	_subNodes = [[NSMutableArray alloc] init];
	
	self.key = key;
	
	return self;
}

- (TNode*)findChildForKey:(NSString*)key {
	
	for (TNode *node in _subNodes) {
		
		if ([node.key isEqualToString:key]) {
			
			return node;
		}
	}
	
	return nil;
}

- (void)addWord:(NSString*)word withIndex:(NSInteger)index {
	
	if (!word || word.length == 0) {
		
		return;
	}
	
	NSString * key = [word substringWithRange:NSMakeRange(0, 1)];
	
	NSString *sub = [word substringWithRange:NSMakeRange(1, [word length] - 1)];
	
	TNode *subNode = [self findChildForKey:key];
	
	if (subNode) {
		
		[subNode addWord:sub withIndex:index];
	}
	else {
		
		subNode = [[TNode alloc] initWithKey:key];
		
		subNode.nIndex = index;
		
		[subNode addWord:sub withIndex:index];
		
		[_subNodes addObject:subNode];
	}
	
	NSMutableDictionary *alphabetMap = [SearchTree sharedInstance].alphabetMap;
	
	NSMutableArray *array = [alphabetMap objectForKey:key];
	
	if (array) {
		
		[array addObject:subNode];
	}
	else {
		
		NSMutableArray *array = [[NSMutableArray alloc] init];
		
		[array addObject:subNode];
		
		[alphabetMap setObject:array forKey:key];
	}
}

- (void)match:(NSString*)word out:(NSMutableArray*)outArray {
	
	NSString * key = [word substringWithRange:NSMakeRange(0, 1)];
	
	if (![key isEqualToString:_key]) {
		
		return;
	}
	
	if (word.length == 1) {
		
		[outArray addObject:self];
		
		return;
	}
	
	NSString *sub = [word substringWithRange:NSMakeRange(1, [word length] - 1)];
	
	for (TNode *node in _subNodes) {
		
		[node match:sub out:outArray];
	}
}

@end
