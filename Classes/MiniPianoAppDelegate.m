//
//  MiniPianoAppDelegate.m
//  MiniPiano
//
//  Created by Steve Streza on 5/13/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MiniPianoAppDelegate.h"
#import "MiniPianoViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "PPStation.h"

@implementation MiniPianoAppDelegate

@synthesize window;
@synthesize viewController;

-(void)pianobarDidLogin:(PPPianobarController *)thePianobar{
	NSLog(@"Login!");

	[stationPicker release];
	stationPicker = [[MPStationPickerController alloc] init];
	stationPicker.pianobar = thePianobar;
	stationPicker.selectedStationHandler = ^(PPStation *station){
		[thePianobar playStationWithID:[station stationID]];

		[musicPlayer release];
		musicPlayer = [[MPPianobarPlayerController alloc] init];
		musicPlayer.pianobar = thePianobar;
		[navigationController pushViewController:musicPlayer animated:YES];
	};
	[navigationController pushViewController:stationPicker animated:YES];
}

-(void)pianobarWillLogin:(PPPianobarController *)pianobar{}

-(void)pianobar:(PPPianobarController *)pianobar didBeginPlayingSong:(PPTrack *)song{
	
}

-(void)pianobar:(PPPianobarController *)pianobar didBeginPlayingChannel:(PPStation *)channel{}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
	
	accountPicker = [[MPAccountPickerController alloc] init];
	accountPicker.accountSelectedHandler = ^(MPAccount *account){
		NSString *username = [account username];
		NSString *password = [account password];
		if(!username && !password) return;
		
		pianobar.delegate = nil;
		[pianobar release];
		
		pianobar = [[PPPianobarController alloc] initWithUsername:username andPassword:password];
		pianobar.delegate = self;
		[pianobar login];
	};
	
	navigationController = [[UINavigationController alloc] initWithRootViewController:accountPicker];
	
    // Override point for customization after app launch    
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
