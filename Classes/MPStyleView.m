//
//  MPStyleView.m
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MPStyleView.h"


@implementation MPStyleView

@synthesize  styleName, styleSheet;

-(VSStyle *)style{
	VSStyleSheet *sheet = self.styleSheet;
	if(!sheet){
		sheet = [VSStyleSheet globalStyleSheet];
	}
	return [sheet styleWithSelector:self.styleName];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	[self drawStyle:[self style] inRect:[self bounds]];
}


- (void)dealloc {
    [super dealloc];
}


@end
