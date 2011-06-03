//
//  HowToViewController.m
//  Amigotchi
//
//  Created by Elliott Kipper on 6/3/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "HowToViewController.h"


@implementation HowToViewController

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
    self.title = @"How To Play";

    CGRect myImageRect = self.view.frame;
    myImageRect.size.height = myImageRect.size.height - 20;
    myImageRect.size.width = myImageRect.size.width + 3;
    UIImageView *myImage = [[UIImageView alloc] initWithFrame:myImageRect];
    [myImage setImage:[UIImage imageNamed:@"howtoscreen.png"]];
    myImage.opaque = YES; // explicitly opaque for performance
    [self.view addSubview:myImage];
    [myImage release];
                      
/*    words.text = @"Your Amigo has wants and needs just like any pet.  Displayed at the top of the screen is your Amigo's happiness and food.  To make your pet happy, pet them.  To feed them, click the food button.\nYour Amigo will also occasionally go to the bathroom, which can cause their happiness to decrease more quickly.  Click the toilet button to clean it.\nTo check in, click the check button.  By checking in to places, you have a chance to find rare accessories for your Amigo!";
 */
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

@end
