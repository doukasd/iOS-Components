//
//  TallyLabelExampleViewController.h
//  TallyLabelExample
//
//  Created by Dimitris Doukas on 28/09/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TallyLabel.h"

@interface TallyLabelExampleViewController : UIViewController {
    TallyLabel *tallyLabel;
    UILabel *targetLabel;
}

@property (nonatomic, retain) IBOutlet TallyLabel *tallyLabel;
@property (nonatomic, retain) IBOutlet UILabel *targetLabel;

- (IBAction)tally:(id)sender;
- (IBAction)tallyLow:(id)sender;
- (IBAction)tallyHigh:(id)sender;

@end
