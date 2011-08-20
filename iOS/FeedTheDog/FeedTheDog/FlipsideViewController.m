//
//  FlipsideViewController.m
//  FeedTheDog
//
//  Created by user on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
#import "Feeder.h"

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize urlTextField;
@synthesize privateKeyTextField;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    urlTextField.text = [[[Feeder sharedFeeder] url] absoluteString];
    privateKeyTextField.text = [[Feeder sharedFeeder] key];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[Feeder sharedFeeder] saveUrlString:urlTextField.text andPrivateKey:privateKeyTextField.text];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
