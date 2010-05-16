//
//  MPAccount.h
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MPAccount : NSObject {
	NSString *_username;
}

@property (nonatomic, readonly) NSString *username;
@property (nonatomic, readonly) NSString *password;

-(id)initWithUsername:(NSString *)username password:(NSString *)password;
-(id)initWithKeychainUsername:(NSString *)username;

@end
