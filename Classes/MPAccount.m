//
//  MPAccount.m
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MPAccount.h"
#import "SFHFKeychainUtils.h"

#define kMPAccountServiceName @"pianobar.account"

@implementation MPAccount

@synthesize username=_username;

-(NSString *)password{
	NSError *error = nil;
	NSString *password = [SFHFKeychainUtils getPasswordForUsername:_username andServiceName:kMPAccountServiceName error:&error];
	if(error || !password){
		return nil;
	}else{
		return password;
	}
}

-(id)initWithUsername:(NSString *)username password:(NSString *)password{
#define FailIfFalse(__cond, __err) if(!(__cond)){ NSLog __err ; goto fail; }
	NSError *err = nil;
	
	[SFHFKeychainUtils storeUsername:username andPassword:password
					  forServiceName:kMPAccountServiceName
					  updateExisting:NO
							   error:&err];
	FailIfFalse(err == nil, (@"Couldn't store keychain - %@",err));
	
	self = [self init];
	FailIfFalse(self != nil, (@"Couldn't create self"));
	
	_username = [username copy];
	FailIfFalse([[self password] isEqualToString:password], (@"Password and stored password are not equal"));
	
	return self;
	
fail:
	[SFHFKeychainUtils deleteItemForUsername:username andServiceName:kMPAccountServiceName error:&err];
	[self release];
	return nil;
}

-(id)initWithKeychainUsername:(NSString *)username{
	NSError *err = nil;
	NSString *password = [SFHFKeychainUtils getPasswordForUsername:username andServiceName:kMPAccountServiceName error:&err];
	if(password){
		return [self initWithUsername:username password:password];
	}else{
		return nil;
	}
}

@end
