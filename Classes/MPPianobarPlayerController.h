//
//  MPPianobarPlayerController.h
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPPianobarController.h"

@interface MPPianobarPlayerController : UIViewController {
	PPPianobarController *_pianobar;
	
	UIImageView *_imageView;
	UISlider *_volumeSlider;
}

@property (nonatomic, retain) PPPianobarController *pianobar;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UISlider *volumeSlider;

-(IBAction)thumbsUp:(id)sender;
-(IBAction)thumbsDown:(id)sender;
-(IBAction)playPause:(id)sender;
-(IBAction)nextSong:(id)sender;
-(IBAction)updateVolume:(id)sender;

@end
