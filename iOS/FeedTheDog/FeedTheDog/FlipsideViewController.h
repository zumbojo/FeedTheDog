//
//  FlipsideViewController.h
//  FeedTheDog
//
//  Created by user on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController {
    IBOutlet UITextField *urlTextField;
    IBOutlet UITextField *privateKeyTextField;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) UITextField *urlTextField;
@property (nonatomic, retain) UITextField *privateKeyTextField;


- (IBAction)done:(id)sender;

@end
