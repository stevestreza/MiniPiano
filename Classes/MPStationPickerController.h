//
//  MPStationPickerController.h
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPPianobarController.h"
#import "PPStation.h"

typedef void (^MPStationPickerHandler)(PPStation *station);

@interface MPStationPickerController : UITableViewController {
	PPPianobarController *_pianobar;
	
	MPStationPickerHandler _selectedStationHandler;
}

@property (nonatomic, retain) PPPianobarController *pianobar;
@property (nonatomic, copy) MPStationPickerHandler selectedStationHandler;

@end
