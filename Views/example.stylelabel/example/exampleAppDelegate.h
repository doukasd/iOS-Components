//
//  exampleAppDelegate.h
//  example
//
//  Created by Dimitris on 14/05/2011.
//  Copyright 2011 unit9.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class exampleViewController;

@interface exampleAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet exampleViewController *viewController;

@end
