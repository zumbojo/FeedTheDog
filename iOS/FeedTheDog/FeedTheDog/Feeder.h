//
//  Feeder.h
//  FeedTheDog
//
//  Created by user on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feeder : NSObject
{
    NSURL *url;
    NSString *key;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSString *key;

+ (Feeder *)sharedFeeder;
- (void)saveUrlString:(NSString *)urlString andPrivateKey:(NSString *)privateKey;

@end
