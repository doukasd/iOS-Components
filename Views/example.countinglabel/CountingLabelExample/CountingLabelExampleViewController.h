//
//  CountingLabelExampleViewController.h
//  CountingLabelExample
//
//  Created by Dimitris Doukas on 28/09/2011.
//  Copyright 2011 unit9.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CountingLabel.h"

@interface CountingLabelExampleViewController : UIViewController {
    CountingLabel *countingLabel;
    UILabel *targetLabel;
}

@property (nonatomic, retain) IBOutlet CountingLabel *countingLabel;
@property (nonatomic, retain) IBOutlet UILabel *targetLabel;

- (IBAction)count:(id)sender;

@end
