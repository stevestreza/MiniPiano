//
//  MiniPianoAppDelegate.h
//  MiniPiano
//
//  Created by Steve Streza on 5/13/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MiniPianoViewController;

@interface MiniPianoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MiniPianoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MiniPianoViewController *viewController;

@end

