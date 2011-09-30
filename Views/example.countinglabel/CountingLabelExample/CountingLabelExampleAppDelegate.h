//
//  CountingLabelExampleAppDelegate.h
//  CountingLabelExample
//
//  Created by Dimitris Doukas on 28/09/2011.
//  Copyright 2011 unit9.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CountingLabelExampleViewController;

@interface CountingLabelExampleAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CountingLabelExampleViewController *viewController;

@end
