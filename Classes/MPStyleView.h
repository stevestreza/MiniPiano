//
//  MPStyleView.h
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VillainousStyle.h"

@interface MPStyleView : UIView {
	NSString *_styleName;
	VSStyleSheet *_styleSheet;
}

@property (nonatomic, copy) NSString *styleName;
@property (nonatomic, retain) VSStyleSheet *styleSheet;

@end
