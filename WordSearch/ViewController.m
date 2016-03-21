//
//  ViewController.m
//  WordSearch
//
//  Created by user on 16/3/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ViewController.h"
#import "SearchTree.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, retain) IBOutlet UISearchBar *ibSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *ibTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	
	NSLog(@"%@", searchText);
}

+ (UITableViewCell *)cellByClassName:(NSString *)className inNib:(NSString *)nibName forTableView:(UITableView *)tableView {
	
	Class cellClass = NSClassFromString(className);
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
	
	if (cell == nil) {
		
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
		
		for (id oneObject in nib)
			
			if ([oneObject isMemberOfClass:cellClass])
				
				return oneObject;
	}
	
	return cell;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 0;
}


@end
