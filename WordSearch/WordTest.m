//
//  WordTest.m
//  WordSearch
//
//  Created by user on 16/3/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "WordTest.h"
#import "Word.h"

@implementation WordTest

- (NSString*)alphabet {
	
	static NSString *alphabet;
	
	if (!alphabet) {
		
		alphabet = @"abcdefghijklmmopqrstuvwxyz";
	}
	
	return alphabet;
}

- (NSString*)createEnglishWord {
	
	NSMutableString *str = [[NSMutableString alloc] init];
	
	NSString *alphabet = [self alphabet];
	
	for (NSInteger i = 0; i < 26; ++i) {
		
		NSInteger nIndex = random() % 25;
		
		[str appendString:[alphabet substringWithRange:NSMakeRange(nIndex, 1)]];
	}
	
	return str;
}

- (NSInteger)weight {
	
	return random() % 7;
}

- (NSString*)chinese {
	
	static NSArray *array;
	
	if (!array) {
		
		array = @[@"受到了看法", @"水电费", @"而非个", @"就好好改变", @"太贱了风格", @"进锐退速"];
	}
	
	NSInteger index = random() % array.count;
	
	return array[index];
}

- (Word*)createOneWord {
	
	Word *word = [[Word alloc] init];
	
	word.english = [self createEnglishWord];
	
	word.weight = [self weight];
	
	word.chinese = [self chinese];
	
	return word;
}

- (NSArray*)createWord:(NSInteger)count {
	
	NSMutableArray *words = [[NSMutableArray alloc] init];
	
	for (NSInteger i = 0; i < count; ++i) {
		
		Word *word = [self createOneWord];
		
		word.nIndex = i;
		
		[words addObject:word];
	}
	
	return words;
}

@end
