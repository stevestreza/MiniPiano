//
//  MPStyleSheet.m
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MPStyleSheet.h"


@implementation MPStyleSheet

- (VSStyle *)playerControlsBackground{
	return 
	 [VSReflectiveFillStyle styleWithColor:VSColorRGB(0.,0.,0.) next:
	  nil
	 ];
}

@end
