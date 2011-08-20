//
//  MainViewController.h
//  FeedTheDog
//
//  Created by user on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	IBOutlet UIButton *feedButton;
	IBOutlet UIActivityIndicatorView* spinner;
}

@property (nonatomic, retain) UIButton *feedButton;
@property (nonatomic, retain) UIActivityIndicatorView* spinner;

- (IBAction)showInfo:(id)sender;
- (IBAction)FeedButtonPressed:(id)sender;

@end
