//
//  MPAccountPickerController.m
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MPAccountPickerController.h"
#import "MPAccountLoginController.h"

@implementation MPAccountPickerController

@synthesize accountSelectedHandler=_accountSelectedHandler;

-(void)createAccount:(id)sender{
	MPAccountLoginController *login = [[MPAccountLoginController alloc] init];
	login.view.frame = self.view.frame;
	
	UIWindow *loginWindow = [[UIWindow alloc] initWithFrame:[self.view window].frame];
	loginWindow.alpha = 0.;
	loginWindow.rootViewController = login;
	[loginWindow makeKeyAndVisible];
		
	[UIView beginAnimations:@"MPAccountLogin" context:self];
	loginWindow.alpha = 1.;
	
	[UIView commitAnimations];
	
	MPAccountLoginHandler loginHandler = ^(NSString *username, NSString *password){
		MPAccount *account = [[[MPAccount alloc] initWithUsername:username password:password] autorelease];
		if(account){
			[self addAccount:account];

			loginWindow.alpha = 0.;
			[loginWindow release];
			[login release];
			
			return YES;
		}else{
			return NO;
		}
	};
	
	login.loginHandler = loginHandler;	
}

-(NSString *)title{
	return @"Accounts";
}

-(NSArray *)accounts{
	if(!_accounts){
		NSMutableArray *newAccounts = [NSMutableArray array];

		NSArray *usernames = [[NSUserDefaults standardUserDefaults] arrayForKey:@"usernames"];
		for(NSString *username in usernames){
			MPAccount *account = [[[MPAccount alloc] initWithKeychainUsername:username] autorelease];
			if(account){
				[newAccounts addObject:account];
			}
		}
		
		_accounts = [newAccounts copy];
	}
	return _accounts;
}

-(void)addAccount:(MPAccount *)account{
	if(!account) return;
	
	[self accounts];
	NSArray *newAccounts = [_accounts arrayByAddingObject:account];
	
	[_accounts autorelease];
	_accounts = [newAccounts retain];
	
	NSMutableArray *usernames = [NSMutableArray array];
	for(MPAccount *account in _accounts){
		[usernames addObject:[account username]];
	}
	
	[[NSUserDefaults standardUserDefaults] setObject:usernames forKey:@"usernames"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																						   target:self
																						   action:@selector(createAccount:)] autorelease];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[self accounts] count];
}

- (MPAccount *)accountAtIndexPath:(NSIndexPath *)indexPath{
	NSArray *accounts = [self accounts];
	if(indexPath.row < accounts.count){
		return [accounts objectAtIndex:indexPath.row];
	}else{
		return nil;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.textLabel.text = [[self accountAtIndexPath:indexPath] username];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	MPAccount *account = [self accountAtIndexPath:indexPath];
	self.accountSelectedHandler(account);
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

