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
#import "ASIHTTPRequest.h"


@interface Feeder ()

- (void)getNonce;
- (void)getNonceSucceeded:(NSString *)unsigned_nonce;
- (void)getNonceFailed:(ASIHTTPRequest *)request;

@end


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

#pragma mark -
- (void)feedFromViewController:(UIViewController<FeedInitiatingViewController> *)viewController
{
    self.feedInitiatingViewController = viewController;

    [self getNonce];
}

#pragma mark HTTP
- (void)getNonce
{
    NSURL *createNonceUrl = [url URLByAppendingPathComponent:@"nonces/create"];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:createNonceUrl];
    [request setCompletionBlock:^{
        // Use when fetching text data
        NSString *responseString = [request responseString];
        
        if ([responseString length] == 32) {
            [self getNonceSucceeded:responseString];
        }
        else {
            [self getNonceFailed:request];
        }
    }];
    [request setDidFailSelector:@selector(getNonceFailed:)];
    [request startAsynchronous];
}

- (void)getNonceSucceeded:(NSString *)unsigned_nonce
{
    [self.feedInitiatingViewController FeedDidFinish];
    NSLog(@"%@", unsigned_nonce);

    // todo
    
}

- (void)getNonceFailed:(ASIHTTPRequest *)request
{
    [self.feedInitiatingViewController FeedDidFinish];
    
    NSString *message;
    NSError *error = [request error];
    
    if (error != nil) {
        message = [error localizedDescription];
    }
    else if ([request responseStatusCode] != 200) {
        message = [NSString stringWithFormat:@"%d", [request responseStatusCode]];
    }
    else {
        message = [request responseString];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OH NOES!" message:message delegate:self cancelButtonTitle:@":(" otherButtonTitles:nil];
    [alert show];
}

@end