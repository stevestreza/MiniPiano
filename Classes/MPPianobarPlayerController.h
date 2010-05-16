//
//  MPPianobarPlayerController.h
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPPianobarController.h"
#import "MPStyleView.h"

@interface MPPianobarPlayerController : UIViewController {
	PPPianobarController *_pianobar;
	
	UIImageView *_imageView;
	UIImage *_currentAlbumArt;
	UISlider *_volumeSlider;
	
	MPStyleView *_controlsBackground;
}

@property (nonatomic, retain) PPPianobarController *pianobar;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UISlider *volumeSlider;
@property (nonatomic, retain) IBOutlet MPStyleView *controlsBackground;

-(IBAction)thumbsUp:(id)sender;
-(IBAction)thumbsDown:(id)sender;
-(IBAction)playPause:(id)sender;
-(IBAction)nextSong:(id)sender;
-(IBAction)updateVolume:(id)sender;

@end
