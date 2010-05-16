//
//  MPPianobarPlayerController.m
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MPPianobarPlayerController.h"
#import "PPTrack.h"
#import "TCDownload.h"

@interface MPPianobarPlayerController (Private)

+(UIImage *)noAlbumArtImage;
-(void)updateView;

@end


@implementation MPPianobarPlayerController

@synthesize pianobar=_pianobar;
@synthesize volumeSlider=_volumeSlider;
@synthesize imageView=_imageView;
@synthesize controlsBackground=_controlsBackground;

static UIImage *sNoAlbumArtImage = nil;
+(UIImage *)noAlbumArtImage{
	if(!sNoAlbumArtImage){
		sNoAlbumArtImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"empty-art" ofType:@"png"]];
	}
	return sNoAlbumArtImage;
}

-(void)pianobarWillLogin:(PPPianobarController *)pianobar{
	[self updateView];	
}

-(void)pianobarDidLogin:(PPPianobarController *)pianobar{
	[self updateView];	
}

-(void)pianobar:(PPPianobarController *)pianobar didBeginPlayingSong:(PPTrack *)song{
	[_currentAlbumArt release];
	_currentAlbumArt = nil;
	
	[self updateView];	
	
	NSURL *url = [song url];
	if([url isKindOfClass:[NSString class]]){
		url = [NSURL URLWithString:(NSString *)url];
	}
	
	NSLog(@"Fetching song URL: %@",url);
	TCDownload *download = [[TCDownload alloc] initWithURL:url];
	download.delegate = self;
	[download send:YES];
}

-(void)downloadFinished:(TCDownload *)download{
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		UIImage *image = [[[UIImage alloc] initWithData:[download data]] autorelease];

		[_currentAlbumArt release];
		_currentAlbumArt = [image retain];
		
		[self updateView];
	}];
}

-(void)pianobar:(PPPianobarController *)pianobar didBeginPlayingChannel:(PPStation *)channel{
	[self updateView];	
}

-(void)setPianobar:(PPPianobarController *)aPianobar{
	_pianobar.delegate = nil;
	
	[aPianobar retain];
	[_pianobar release];
	_pianobar = aPianobar;
	
	_pianobar.delegate = self;
	[self updateView];
}

-(void)updateView{
	PPTrack *nowPlaying = [self.pianobar nowPlaying];
	
	[self setTitle:nowPlaying.title];
	_volumeSlider.value = self.pianobar.volume;
	
	_imageView.image = (_currentAlbumArt == nil ? [[self class] noAlbumArtImage] : _currentAlbumArt);
}

-(IBAction)thumbsUp:(id)sender{
	[self.pianobar thumbsUpCurrentSong:sender];
}

-(IBAction)thumbsDown:(id)sender{
	[self.pianobar thumbsDownCurrentSong:sender];
}

-(IBAction)playPause:(id)sender{
	[self.pianobar playPauseCurrentSong:sender];
}

-(IBAction)nextSong:(id)sender{
	[self.pianobar playNextSong:sender];
}

-(IBAction)updateVolume:(id)sender{
	self.pianobar.volume = _volumeSlider.value;
	[self updateView];
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

-(void)viewWillAppear:(BOOL)animated{
	[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	if([self becomeFirstResponder]){
	}
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
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
	self.controlsBackground.styleName = @"playerControlsBackground";
	[self updateView];
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
