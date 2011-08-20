//
//  Feeder.m
//  FeedTheDog
//
//  Created by user on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define URL_STRING_DEFAULTS_KEY @"urlString"
#define PRIVATE_KEY_DEFAULTS_KEY @"privateKey"

#import "Feeder.h"
#import "SynthesizeSingleton.h"

@implementation Feeder

SYNTHESIZE_SINGLETON_FOR_CLASS(Feeder);

@synthesize url;
@synthesize key;
@synthesize feedInitiatingViewController;

#pragma mark NSUserDefaults
- (void)loadDefaults
{
    self.url = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults] stringForKey:URL_STRING_DEFAULTS_KEY]];
    self.key = [[NSUserDefaults standardUserDefaults] stringForKey:PRIVATE_KEY_DEFAULTS_KEY];
}

- (void)saveUrlString:(NSString *)urlString andPrivateKey:(NSString *)privateKey;
{
    // update existing:
    self.url = urlString != nil ? [NSURL URLWithString:urlString] : nil;
    self.key = privateKey != nil ? [NSString stringWithString:privateKey] : nil;
    
    // save:
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:urlString forKey:URL_STRING_DEFAULTS_KEY];
    [defaults setValue:privateKey forKey:PRIVATE_KEY_DEFAULTS_KEY];
    [defaults synchronize];
}

#pragma -
- (void)feedFromViewController:(UIViewController<FeedInitiatingViewController> *)viewController
{
    self.feedInitiatingViewController = viewController;
    
    // for testing:
    NSLog(@"feed");
    [self.feedInitiatingViewController FeedDidFinish];
}

// todo: do the network stuff, when finished call [self.feedInitiatingViewController FeedDidFinish]

@end