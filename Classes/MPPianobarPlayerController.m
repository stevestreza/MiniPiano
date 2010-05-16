//
//  MPPianobarPlayerController.m
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MPPianobarPlayerController.h"
#import "PPTrack.h"

@implementation MPPianobarPlayerController

@synthesize pianobar=_pianobar;
@synthesize volumeSlider=_volumeSlider;
@synthesize imageView=_imageView;

-(void)updateView{
	PPTrack *nowPlaying = [self.pianobar nowPlaying];
}

-(NSString *)title{
	return self.pianobar.nowPlaying.title;
}

-(IBAction)thumbsUp:(id)sender{
	
}

-(IBAction)thumbsDown:(id)sender{
	
}

-(IBAction)playPause:(id)sender{
	
}

-(IBAction)nextSong:(id)sender{
	
}

-(IBAction)updateVolume:(id)sender{
	
}

- (BOOL)canBecomeFirstResponder{
	return YES;
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)theEvent{
	if (theEvent.type == UIEventTypeRemoteControl) {
        switch(theEvent.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
				[self.pianobar playPauseCurrentSong:self];
                break;
           case UIEventSubtypeRemoteControlNextTrack:
				[self.pianobar playNextSong:self];
                break;
            default:
                return;
		}
	}
}

-(void)viewDidAppear:(BOOL)animated{
	[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	if([self becomeFirstResponder]){
		NSLog(@"First!");
	}
}

-(void)viewWillDisappear:(BOOL)animated{
	[[UIApplication sharedApplication] endReceivingRemoteControlEvents];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if([self.view nextResponder] == self){
		NSLog(@"Awww yeah");
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
