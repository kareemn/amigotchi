//
//  AmigoInfoController.m
//  Amigotchi
//
//  Created by Kareem Nassar on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoInfoController.h"
#import "AppDelegate.h"

@implementation AmigoInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (toggleCheckins != nil) {
        toggleCheckins.on = delegate.api.facebookCheckinEnabled;
    }
    
    if (logoutButton != nil) {
        UIImage *logoutImage = [UIImage imageNamed:@"LogoutNormal.png"];
        [logoutButton setImage:logoutImage forState:UIControlStateNormal];
        [logoutImage release];
    }
    
    [table setDelegate:self];
    
    NSLog(@"%@",delegate.api.pet.name);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) facebookCheckinToggled:(id)sender{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.api.facebookCheckinEnabled = toggleCheckins.on;
}


- (IBAction) logoutPressed:(id)sender{
    NSLog(@"logging out");
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"loggingout"]];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0)
    {
        return 1;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
    
    // Set up the cell...
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if(indexPath.section == 0)
    {
        cell.textLabel.text = delegate.api.pet.name;
        cell.detailTextLabel.text= @"Amigo's Name";
    }
    else
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%d", delegate.api.pet.happiness];
            cell.detailTextLabel.text= @"Happiness";
        }
        if(indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%d", delegate.api.pet.hunger];
            cell.detailTextLabel.text= @"Hunger";
        }
        if(indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%d", delegate.api.pet.age];
            cell.detailTextLabel.text= @"Age";
        }
        if(indexPath.row == 3)
        {
            cell.textLabel.text = delegate.api.pet.accessory;
            cell.detailTextLabel.text= @"Accessory";
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

@end
