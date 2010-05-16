//
//  MPAccountLoginController.h
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL (^MPAccountLoginHandler)(NSString *username, NSString *password);

@interface MPAccountLoginController : UIViewController {
	UIView *_formView;
	UITextField *_usernameField;
	UITextField *_passwordField;
	
	MPAccountLoginHandler _loginHandler;
}

@property (nonatomic, retain) IBOutlet UIView *formView;
@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, copy) MPAccountLoginHandler loginHandler;

@end
