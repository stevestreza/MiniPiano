//
//  MiniPianoAppDelegate.h
//  MiniPiano
//
//  Created by Steve Streza on 5/13/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPPianobarController.h"

#import "MPAccountPickerController.h"
#import "MPStationPickerController.h"
#import "MPPianobarPlayerController.h"

#import "MPAccount.h"

@class MiniPianoViewController;

@interface MiniPianoAppDelegate : NSObject <UIApplicationDelegate, PPPianobarDelegate> {
    UIWindow *window;
    MiniPianoViewController *viewController;
	
	UINavigationController *navigationController;
	
	MPAccount *selectedAccount;

	PPPianobarController *pianobar;	
	MPAccountPickerController *accountPicker;
	MPStationPickerController *stationPicker;
	MPPianobarPlayerController *musicPlayer;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MiniPianoViewController *viewController;

-(void)loginToAccount:(MPAccount *)account;

@end

