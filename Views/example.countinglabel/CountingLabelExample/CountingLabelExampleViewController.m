//
//  CountingLabelExampleViewController.m
//  CountingLabelExample
//
//  Created by Dimitris Doukas on 28/09/2011.
//  Copyright 2011 unit9.com. All rights reserved.
//

#import "CountingLabelExampleViewController.h"

@implementation CountingLabelExampleViewController

@synthesize countingLabel, targetLabel;

- (void)dealloc {
    self.countingLabel = nil;
    self.targetLabel = nil;
    [super dealloc];
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set the desired format for the label - it's defined in IB instead
    //self.countingLabel.stringFormat = @"%05d units";
    
    [self count:nil];
}

#pragma mark IBActions

- (IBAction)animationDurationChanged:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            self.countingLabel.animationDuration = 1;
            break;
        case 1:
            self.countingLabel.animationDuration = 2;
            break;
        case 2:
            self.countingLabel.animationDuration = 5;
            break;
        default:
            break;
    }
}

- (IBAction)count:(id)sender
{
    NSInteger newNumber = arc4random() % 100000;
    self.targetLabel.text = [NSString stringWithFormat:@"counting to: %d", newNumber];
    self.countingLabel.text = [NSString stringWithFormat:@"%d", newNumber];
}

@end
