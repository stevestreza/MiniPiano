//
//  MPAccountPickerController.h
//  MiniPiano
//
//  Created by Steve Streza on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAccount.h"

typedef void (^MPAccountPickerHandler)(MPAccount *account);

@interface MPAccountPickerController : UITableViewController {
	NSArray *_accounts;
	MPAccountPickerHandler _accountSelectedHandler;
}
@property (nonatomic, copy) MPAccountPickerHandler accountSelectedHandler;

- (MPAccount *)accountAtIndexPath:(NSIndexPath *)indexPath;
@end
