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

static NSInteger count = 0;

@implementation TNode

- (id)init {
	
	self = [super init];
	
//	_subNodes = [[NSMutableArray alloc] init];
	
	return self;
}

- (NSInteger)count {
	
	return count;
}

- (id)initWithKey:(unichar)key {
	
	self = [super init];
	
//	_subNodes = [[NSMutableArray alloc] init];
	
	_key = key;
	
	++count;

	return self;
}

- (TNode*)findChildForKey:(unichar)key {
	
	for (TNode *node in _subNodes) {
		
		if (node.key == key) {
			
			return node;
		}
	}
	
	return nil;
}

- (void)addWord:(NSString*)word withIndex:(NSInteger)index {
	
	if (!word || word.length == 0) {
		
		return;
	}
	
	unichar key = [word characterAtIndex:0];
	
	NSString *sub = [word substringWithRange:NSMakeRange(1, [word length] - 1)];
	
	TNode *subNode = [self findChildForKey:key];
	
	if (subNode) {
		
		[subNode addWord:sub withIndex:index];
	}
	else {
		
		subNode = [[TNode alloc] initWithKey:key];
		
		subNode.nIndex = index;
		
		[subNode addWord:sub withIndex:index];
		
		if (!_subNodes) {
			
			_subNodes = [[NSMutableArray alloc] init];
		}
		
		[_subNodes addObject:subNode];
	}
	
	NSMutableDictionary *alphabetMap = [SearchTree sharedInstance].alphabetMap;
	
	NSMutableArray *array = [alphabetMap objectForKey:[NSNumber numberWithInteger:key]];
	
	if (array) {
		
		[array addObject:subNode];
	}
	else {
		
		NSMutableArray *array = [[NSMutableArray alloc] init];
		
		[array addObject:subNode];
		
		[alphabetMap setObject:array forKey:[NSNumber numberWithInteger:key]];
	}
}

- (void)match:(NSString*)word out:(NSMutableArray*)outArray {
	
	if (word.length == 0) {
		
		return;
	}
	
	unichar key = [word characterAtIndex:0];
	
	if (key != _key) {
		
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
