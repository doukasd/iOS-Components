//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MultiDialViewController.h"

@interface Dial_ExampleViewController : UIViewController <MultiDialViewControllerDelegate> {
    MultiDialViewController *multiDialController;
}

@property (nonatomic, retain) IBOutlet UILabel *selectedStringLabel;
@property (nonatomic, retain) IBOutlet UITextView *presetStringsView;

- (IBAction)switchPresetStrings:(id)sender;
- (IBAction)spinToRandom:(id)sender;

@end
