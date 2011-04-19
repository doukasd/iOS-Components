//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import "Dial_ExampleViewController.h"

#import "MultiDialViewController.h"

@implementation Dial_ExampleViewController

@synthesize selectedStringLabel, presetStringsView;

- (void)dealloc
{
    [multiDialController release];
    multiDialController = nil;
    
    self.selectedStringLabel = nil;
    self.presetStringsView = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    multiDialController = [[MultiDialViewController alloc] init];
    multiDialController.delegate = self;
    multiDialController.view.frame = CGRectOffset(multiDialController.view.frame, 0.0, 340.0);
    [self.view addSubview:multiDialController.view];
    
    //init
    [self switchPresetStrings:nil];
}


- (void)viewDidUnload
{    
    [super viewDidUnload];
    
    [multiDialController release];
    multiDialController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark IBActions

- (void)switchPresetStrings:(id)sender {
    if ([(UISwitch *)sender isOn]) {
        multiDialController.presetStrings = [[[NSArray alloc] initWithObjects:@"000A", @"111A", @"222B", @"333C", @"360D", nil] autorelease];
    }
    else {
        multiDialController.presetStrings = nil;
    }
    self.presetStringsView.text = [NSString stringWithFormat:@"%@", multiDialController.presetStrings];
}

- (void)spinToRandom:(id)sender {
    [multiDialController spinToRandomString:YES];
}

#pragma mark MultiDialViewControllerDelegate methods

- (void)multiDialViewController:(MultiDialViewController *)controller didSelectString:(NSString *)string {
    self.selectedStringLabel.text = string;
}

@end
