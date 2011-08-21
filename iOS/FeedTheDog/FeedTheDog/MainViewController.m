//
//  MainViewController.m
//  FeedTheDog
//
//  Created by user on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

- (void)flashSuccessLabel;

@end


@implementation MainViewController

@synthesize feedButton;
@synthesize spinner;
@synthesize successLabel;

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
}

- (IBAction)FeedButtonPressed:(id)sender
{
    [self.spinner startAnimating];
    [[Feeder sharedFeeder] feedFromViewController:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark FeedInitiatingViewController:
- (void)FeedDidFinishWithSuccess:(bool)success
{
    [self.spinner stopAnimating];
    
    if (success) {
        [self flashSuccessLabel];
    }
}

- (void)flashSuccessLabel {
    [self.successLabel setAlpha:1];
    
    // from http://stackoverflow.com/questions/2591363/uilabel-fade-in-fade-out-question/2591473#2591473
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2.0];
    [self.successLabel setAlpha:0];
    [UIView commitAnimations];
}

@end
