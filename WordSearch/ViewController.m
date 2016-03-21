//
//  ViewController.m
//  WordSearch
//
//  Created by user on 16/3/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ViewController.h"
#import "SearchTree.h"
#import "SearchCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, retain) IBOutlet UISearchBar *ibSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *ibTableView;
@property (nonatomic, retain) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	
	_dataSource = [[SearchTree sharedInstance] find:searchText];
	
	[_ibTableView reloadData];
}

- (UITableViewCell *)cellByClassName:(NSString *)className inNib:(NSString *)nibName forTableView:(UITableView *)tableView {
	
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
	
	if (indexPath.row >= _dataSource.count) {
		
		return nil;
	}
	
	SearchCell *cell = (SearchCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
	
	if (!cell) {
		
		cell = (SearchCell*)[self cellByClassName:@"SearchCell" inNib:@"SearchCell" forTableView:tableView];
	}
	
	NSInteger index = [_dataSource[indexPath.row] integerValue];
	
	KeyWord *word = [[SearchTree sharedInstance] retriveWord:index];
	
	[cell setWord:word];
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [_dataSource count];
}


@end
