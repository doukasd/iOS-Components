//
//  TallyLabelExampleViewController.m
//  TallyLabelExample
//
//  Created by Dimitris Doukas on 28/09/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import "TallyLabelExampleViewController.h"


@interface TallyLabelExampleViewController ()
- (void)tallyTo:(NSInteger)number;
@end


@implementation TallyLabelExampleViewController

@synthesize tallyLabel, targetLabel;

- (void)dealloc {
    self.tallyLabel = nil;
    self.targetLabel = nil;
    [super dealloc];
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set the desired format for the label - it's defined in IB instead
    //self.tallyLabel.stringFormat = @"%05d units";
    
    [self tally:nil];
}

- (void)tallyTo:(NSInteger)number {
    self.targetLabel.text = [NSString stringWithFormat:@"tallying to: %d", number];
    self.tallyLabel.text = [NSString stringWithFormat:@"%d", number];
}

#pragma mark IBActions

- (IBAction)animationDurationChanged:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            self.tallyLabel.animationDuration = 1;
            break;
        case 1:
            self.tallyLabel.animationDuration = 2;
            break;
        case 2:
            self.tallyLabel.animationDuration = 5;
            break;
        default:
            break;
    }
}

- (IBAction)tally:(id)sender
{
    NSInteger newNumber = arc4random() % 100000;
    [self tallyTo:newNumber];
}

- (IBAction)tallyLow:(id)sender
{
    NSInteger newNumber = 0;
    [self tallyTo:newNumber];
}

- (IBAction)tallyHigh:(id)sender
{
    NSInteger newNumber = 99999;
    [self tallyTo:newNumber];
}

@end
