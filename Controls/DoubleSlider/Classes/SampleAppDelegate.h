//
//  SampleAppDelegate.h
//  Sample
//
//  Created by Dimitris on 14/07/2010.
//  Copyright locus-delicti.com 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SampleViewController;

@interface SampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SampleViewController *viewController;

@end

