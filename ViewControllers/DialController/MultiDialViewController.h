//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DialController.h"

@protocol MultiDialViewControllerDelegate;

@interface MultiDialViewController : UIViewController  <UIAccelerometerDelegate, DialControllerDelegate> {
    id<MultiDialViewControllerDelegate> delegate;
    
    DialController *dial1;
    DialController *dial2;
    DialController *dial3;
    DialController *dial4;
    
    //optional array of preset values
	NSArray *presetStrings;
}

@property (nonatomic, assign) id<MultiDialViewControllerDelegate> delegate;

@property (nonatomic, retain) DialController *dial1;
@property (nonatomic, retain) DialController *dial2;
@property (nonatomic, retain) DialController *dial3;
@property (nonatomic, retain) DialController *dial4;

@property (nonatomic, retain) NSArray *presetStrings;

- (void)spinToRandomString:(BOOL)preset;

@end


@protocol MultiDialViewControllerDelegate 
- (void)multiDialViewController:(MultiDialViewController *)controller didSelectString:(NSString *)string;
@end