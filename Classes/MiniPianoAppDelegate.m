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
#import "MPPianobarPlayerController.h"
#import "MPStationPickerController.h"

@implementation MiniPianoAppDelegate

@synthesize window;
@synthesize viewController;

-(void)pianobarDidLogin:(PPPianobarController *)thePianobar{
	NSLog(@"Login!");
	MPStationPickerController *picker = [[MPStationPickerController alloc] init];
	picker.pianobar = thePianobar;
	picker.selectedStationHandler = ^(PPStation *station){
		[thePianobar playStationWithID:[station stationID]];

		MPPianobarPlayerController *player = [[MPPianobarPlayerController alloc] init];
		player.pianobar = thePianobar;
		[navigationController pushViewController:player animated:YES];
	};
	[navigationController pushViewController:picker animated:YES];
}

-(void)pianobarWillLogin:(PPPianobarController *)pianobar{}

-(void)pianobar:(PPPianobarController *)pianobar didBeginPlayingSong:(PPTrack *)song{
	
}

-(void)pianobar:(PPPianobarController *)pianobar didBeginPlayingChannel:(PPStation *)channel{}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
	navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	
    // Override point for customization after app launch    
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
	
	NSString *pandoraEmail = nil;
	NSString *pandoraPassword = nil;
	
	if(pandoraEmail && pandoraPassword){
		pianobar = [[PPPianobarController alloc] initWithUsername:pandoraEmail
													  andPassword:pandoraPassword];
		pianobar.delegate = self;
		[pianobar login];
	}else{
		NSLog(@"Add your username/password!");
	}
	
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
