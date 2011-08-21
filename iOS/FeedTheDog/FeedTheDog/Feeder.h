//
//  Feeder.h
//  FeedTheDog
//
//  Created by user on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FeedInitiatingViewController;

@interface Feeder : NSObject
{
    NSURL *url;
    NSString *key;
    UIViewController<FeedInitiatingViewController> *feedInitiatingViewController;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) UIViewController<FeedInitiatingViewController> *feedInitiatingViewController;

+ (Feeder *)sharedFeeder;
- (void)loadDefaults;
- (void)saveUrlString:(NSString *)urlString andPrivateKey:(NSString *)privateKey;
- (void)feedFromViewController:(UIViewController<FeedInitiatingViewController> *)viewController;

@end


@protocol FeedInitiatingViewController <NSObject>

@optional

- (void)FeedDidFinishWithSuccess:(bool)success;

@end