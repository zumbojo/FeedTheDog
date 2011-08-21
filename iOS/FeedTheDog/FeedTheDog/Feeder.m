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
#import <CommonCrypto/CommonDigest.h>


@interface Feeder ()

- (void)getNonce;
- (void)signAndPostNonce:(NSString *)unsigned_nonce; // "getNonceSucceeded"
- (void)getNonceFailed:(ASIHTTPRequest *)request;

- (NSString*)sha256:(NSString *)clear;

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

#pragma mark HTTP: GET nonce
- (void)getNonce
{
    NSURL *createNonceUrl = [url URLByAppendingPathComponent:@"nonces/create"];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:createNonceUrl];
    [request setCompletionBlock:^{
        // Use when fetching text data
        NSString *responseString = [request responseString];
        
        if ([responseString length] == 32) {
            [self signAndPostNonce:responseString];
        }
        else {
            [self getNonceFailed:request];
        }
    }];
    [request setDidFailSelector:@selector(getNonceFailed:)];
    [request startAsynchronous];
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

#pragma mark HTTP: sign, POST nonce
- (void)signAndPostNonce:(NSString *)unsigned_nonce {
    NSString *signed_nonce = [self sha256:unsigned_nonce];
    
    NSLog(@"%@", signed_nonce);
    
//    irb(main):003:0> Nonce.last.unsigned_nonce
//    => "mwxhyfuagdrgcoxrjatpsrgqjvdpbxiv"
//    irb(main):004:0> Nonce.last.signed_nonce
//    => "df7fb55040efcd9aac8df49f4fb0531365945978412f4b92d7292283a728c0c6"
}
    
// from http://stackoverflow.com/questions/4992109/generate-sha256-string-in-objective-c/4995996#4995996
- (NSString*)sha256:(NSString *)clear {
    const char *s=[clear cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

@end