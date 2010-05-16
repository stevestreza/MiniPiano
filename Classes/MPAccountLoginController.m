    //
//  MPAccountLoginController.m
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MPAccountLoginController.h"
#import <QuartzCore/QuartzCore.h>

@implementation MPAccountLoginController

@synthesize formView=_formView;
@synthesize usernameField=_usernameField;
@synthesize passwordField=_passwordField;
@synthesize loginHandler=_loginHandler;

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if(textField == self.usernameField){
		[self.passwordField becomeFirstResponder];
		return YES;
	}else if(textField == self.passwordField){
		[[self retain] autorelease];
		BOOL retVal = self.loginHandler(self.usernameField.text, self.passwordField.text);
		
		if(retVal){
			[self.passwordField resignFirstResponder];
		}
		return retVal;
	}else{
		return YES;
	}
}

-(void)keyboardWillShow:(NSNotification *)notif{
	CGRect frame = [(NSValue *)[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]   CGRectValue];
	
	double heightDelta = frame.size.height;
	CGRect ourFrame = self.view.frame;
	ourFrame.size.height -= heightDelta;
	self.view.frame = ourFrame;
}

-(void)keyboardWillHide:(NSNotification *)notif{
	CGRect frame = [(NSValue *)[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]   CGRectValue];
	
	double heightDelta = frame.size.height;
	CGRect ourFrame = self.view.frame;
	ourFrame.size.height += heightDelta;
	self.view.frame = ourFrame;	
}

-(void)viewWillAppear:(BOOL)animated{
	NSLog(@"Will appear");
	[self.usernameField becomeFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated{
	NSLog(@"Did appear");
}

-(id)init{
	if(self = [self initWithNibName:@"MPAccountLogin" bundle:nil]){
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	}
	return self;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.formView.layer.cornerRadius = 10.;
	self.formView.layer.shadowColor = [[UIColor blackColor] CGColor];
	self.formView.layer.shadowOffset = CGSizeMake(0, 0);
	self.formView.layer.shadowRadius = 5.;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
