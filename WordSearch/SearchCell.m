//
//  SearchCell.m
//  WordSearch
//
//  Created by user on 16/3/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SearchCell.h"
#import "Word.h"

@interface SearchCell()

@property (nonatomic, retain) IBOutlet UILabel *ibEnglish;
@property (nonatomic, retain) IBOutlet UILabel *ibChinese;

@end

@implementation SearchCell

- (void)setWord:(Word*)word {
	
	[_ibEnglish setText:word.english];
	
	[_ibChinese setText:word.chinese];
}

@end
