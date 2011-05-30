//
//  exampleViewController.m
//  example
//
//  Created by Dimitris on 14/05/2011.
//  Copyright 2011 unit9.com. All rights reserved.
//

#import "exampleViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "StyleLabel.h"

@implementation exampleViewController

- (void)dealloc
{
    [styleLabel release];
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
    
    styleLabel = [[StyleLabel alloc] initWithText:@"The big brown Φόξ!"
                                        gradientColors:[NSArray arrayWithObjects:[UIColor redColor],[UIColor blueColor], [UIColor whiteColor], nil]];
    styleLabel.textAlignment = UITextAlignmentCenter;
    styleLabel.center = self.view.center;
    [self.view addSubview:styleLabel];    
    
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b1 setTitle:@"change font" forState:UIControlStateNormal];
    b1.frame = CGRectMake(5, 5, 100, 40);
    b1.tag = 1;
    [b1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b1];
    
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b2 setTitle:@"change text" forState:UIControlStateNormal];
    b2.frame = CGRectMake(5, 50, 100, 40);
    b2.tag = 2;
    [b2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b2];
    
    UIButton *b3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b3 setTitle:@"change frame" forState:UIControlStateNormal];
    b3.frame = CGRectMake(5, 95, 100, 40);
    b3.tag = 3;
    [b3 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b3];
}

- (void)buttonPressed:(id)sender {
    switch ([(UIButton *)sender tag]) {
        case 1:
            styleLabel.font = [UIFont boldSystemFontOfSize:32.0];
            break;
        case 2:
            styleLabel.text = @"Alternate weird text: 汉语/漢語";
            break;
        case 3:
            styleLabel.frame = CGRectMake(0, 200, 280, 100);
            break;
        default:
            break;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
