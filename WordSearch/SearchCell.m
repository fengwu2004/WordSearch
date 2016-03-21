//
//  SearchCell.m
//  WordSearch
//
//  Created by user on 16/3/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SearchCell.h"
#import "KeyWord.h"

@interface SearchCell()

@property (nonatomic, retain) IBOutlet UILabel *ibEnglish;
@property (nonatomic, retain) IBOutlet UILabel *ibChinese;

@end

@implementation SearchCell

- (void)setWord:(KeyWord*)word {
	
	[_ibEnglish setText:word.word];
	
	[_ibChinese setText:word.text];
}

@end
