//
//  CheckinDataSource.m
//  Amigotchi
//
//  Created by Kareem Nassar on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckinDataSource.h"

@implementation CheckinDataSource

- (id) init {
	checkins = [[NSMutableArray alloc] init];
    
    
	[checkins addObject:[NSDictionary
                       dictionaryWithObjects:[NSArray arrayWithObjects:@"red", [UIColor redColor], nil]
                       forKeys:[NSArray arrayWithObjects:@"name", @"color", nil]]];
	[checkins addObject:[NSDictionary
                       dictionaryWithObjects:[NSArray arrayWithObjects:@"blue", [UIColor blueColor], nil]
                       forKeys:[NSArray arrayWithObjects:@"name", @"color", nil]]];
	[checkins addObject:[NSDictionary
                       dictionaryWithObjects:[NSArray arrayWithObjects:@"green", [UIColor greenColor], nil]
                       forKeys:[NSArray arrayWithObjects:@"name", @"color", nil]]];
    
    
	return self;
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [checkins count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSDictionary *myCell = [checkins objectAtIndex:[indexPath row]];
    
	UITableViewCell *newCell = [[UITableViewCell alloc] init];
	UILabel *newCellLabel = [newCell textLabel];
    
	[newCellLabel setText:[myCell objectForKey:@"name"]];
	[newCellLabel setTextColor:[myCell objectForKey:@"color"]];
    
	return newCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (void) dealloc {
    [checkins release];
    [super dealloc];
}

@end

