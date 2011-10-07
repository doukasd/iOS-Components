//
//  TallyingLabelExampleAppDelegate.h
//  TallyingLabelExample
//
//  Created by Dimitris Doukas on 28/09/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TallyLabelExampleViewController;

@interface TallyLabelExampleAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TallyLabelExampleViewController *viewController;

@end
