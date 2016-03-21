//
//  TNodeCreate.m
//  CollectiveView
//
//  Created by user on 16/3/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SearchTree.h"
#import "TNode.h"
#import "KeyWord.h"

@interface SearchTree()

@property (nonatomic, retain) NSMutableArray *allWords;
@property (nonatomic, retain) TNode *root;

@end

@implementation SearchTree

+ (SearchTree*)sharedInstance {
	
	static SearchTree *_instance = nil;
	
	static dispatch_once_t predicate;
	
	dispatch_once(&predicate, ^{
		
		_instance = [[SearchTree alloc] init];
	});
	
	return _instance;
}

- (id)init {
	
	self = [super init];
	
	if (self) {
		
		_alphabetMap = [[NSMutableDictionary alloc] init];
		
		_allWords = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (KeyWord*)retriveWord:(NSInteger)nIndex {
	
	if (nIndex >= _allWords.count) {
		
		return nil;
	}
	
	return _allWords[nIndex];
}

- (void)load {
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"txt"];
	
	NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
	
	NSArray *array = [str componentsSeparatedByString:@"\n"];
	
	for (NSInteger i = 0; i < array.count; ++i) {
		
		NSString *word = array[i];
		
		NSArray *subWords = [word componentsSeparatedByString:@"\t"];
		
		if (subWords.count < 3) {
			
			continue;
		}
		
		KeyWord *keyword = [[KeyWord alloc] init];
		
		keyword.nIndex = i;
		
		keyword.word = [subWords[0] lowercaseString];
		
		keyword.text = subWords[1];
		
		keyword.value = [subWords[2] integerValue];
		
		[_allWords addObject:keyword];
	}
}

- (void)create {
	
	[self load];
	
	[self buildTree];
}

- (void)buildTree {
	
	_root = [[TNode alloc] init];
	
	for (NSInteger i = 0; i < _allWords.count; ++i) {
		
		KeyWord *keyword = _allWords[i];
		
		NSString *value = keyword.word;
		
		[_root addWord:value withIndex:keyword.nIndex];
	}
}

- (NSArray*)find:(NSString*)word {
	
	NSString *key = [word substringWithRange:NSMakeRange(0, 1)];
	
	NSArray *nodes = [_alphabetMap objectForKey:key];
	
	if (!nodes) {
		
		return nil;
	}
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (TNode *node in nodes) {
		
		[node match:word out:array];
	}
	
	NSMutableSet *resultSet = [[NSMutableSet alloc] init];
	
	[self store:array out:resultSet];
	
	return [self sort:resultSet];
}

- (NSArray*)sort:(NSMutableSet*)unsortResult {
	
	NSArray *array = [unsortResult allObjects];
	
	return [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
		
		NSInteger index1 = [obj1 integerValue];
		
		NSInteger index2 = [obj2 integerValue];
		
		KeyWord *keyWord1 = _allWords[index1];
		
		KeyWord *keyWord2 = _allWords[index2];
		
		if (keyWord1.value > keyWord2.value) {
			
			return NSOrderedDescending;
		}
		
		return NSOrderedAscending;
	}];
}

- (void)store:(NSArray *)nodes out:(NSMutableSet*)result {
	
	for (TNode *node in nodes) {
		
		if ([node.subNodes count] == 0) {
			
			NSNumber *number = [NSNumber numberWithInteger:node.nIndex];
			
			[result addObject:number];
		}
		else {
			
			[self store:node.subNodes out:result];
		}
	}
}

@end
