//
//  SampleViewController.m
//  Sample
//
//  Created by Dimitris on 14/07/2010.
//  Copyright locus-delicti.com 2010. All rights reserved.
//

#import "SampleViewController.h"
#import "DoubleSlider.h"

#define SLIDER_VIEW_TAG     1234

@interface SampleViewController (PrivateMethods)
- (void)valueChangedForDoubleSlider:(DoubleSlider *)slider;
@end


@implementation SampleViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//DoubleSlider setup
	DoubleSlider *slider = [DoubleSlider doubleSlider];
	[slider addTarget:self action:@selector(valueChangedForDoubleSlider:) forControlEvents:UIControlEventValueChanged];
	slider.center = self.view.center;
    slider.tag = SLIDER_VIEW_TAG; //for testing purposes only
	[self.view addSubview:slider];
	
	leftLabel = [[UILabel alloc] initWithFrame:CGRectOffset(slider.frame, 0, -slider.frame.size.height)];
	leftLabel.textAlignment = UITextAlignmentLeft;
	leftLabel.backgroundColor = [UIColor clearColor];
	[self.view addSubview:leftLabel];
	
	rightLabel = [[UILabel alloc] initWithFrame:CGRectOffset(slider.frame, 0, -slider.frame.size.height)];
	rightLabel.textAlignment = UITextAlignmentRight;
	rightLabel.backgroundColor = [UIColor clearColor];
	[self.view addSubview:rightLabel];
	
	//get the initial values
    //slider.transform = CGAffineTransformRotate(slider.transform, 90.0/180*M_PI);      //make it vertical
    
    //dynamically set the slider positions
    //[slider moveSlidersToPosition:[NSNumber numberWithInt:5] :[NSNumber numberWithInt:77] animated:NO];
    
    //add button to test moving the sliders
    UIButton *devButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [devButton setFrame:CGRectMake(0, 0, 160, 40)];
    [devButton setCenter:CGPointMake(self.view.center.x, self.view.center.y + 160.0)];
    [devButton setTitle:@"snap to random" forState:UIControlStateNormal];
    [devButton addTarget:self action:@selector(devButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:devButton];

	[self valueChangedForDoubleSlider:slider];
}


#pragma mark Control Event Handlers

- (void)valueChangedForDoubleSlider:(DoubleSlider *)slider
{
	leftLabel.text = [NSString stringWithFormat:@"%0.1f", slider.minSelectedValue];
	rightLabel.text = [NSString stringWithFormat:@"%0.1f", slider.maxSelectedValue];
}

- (void)devButtonHandler:(id)sender {
    DoubleSlider *slider = (DoubleSlider *)[self.view viewWithTag:SLIDER_VIEW_TAG];
    if (slider) {
        [slider moveSlidersToPosition:[NSNumber numberWithInt:arc4random() % 50] :[NSNumber numberWithInt:51 + arc4random() % 50] animated:YES];
    }
}

#pragma mark -

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[leftLabel release];
	[rightLabel release];
	
    [super dealloc];
}

@end
