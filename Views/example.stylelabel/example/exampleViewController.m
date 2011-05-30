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
                                        gradientColors:[NSArray arrayWithObjects:
                                                        [UIColor colorWithRed:0.8 green:0.8 blue:0.9 alpha:1.0],
                                                        [UIColor colorWithRed:0.3 green:0.6 blue:0.8 alpha:1.0],
                                                        [UIColor colorWithRed:0.0 green:0.2 blue:0.4 alpha:1.0],
                                                        nil]];
    styleLabel.textAlignment = UITextAlignmentCenter;
    styleLabel.center = self.view.center;
    [self.view addSubview:styleLabel];    
    
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b1 setTitle:@"change font" forState:UIControlStateNormal];
    b1.frame = CGRectMake(5, 5, 110, 30);
    b1.tag = 1;
    [b1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b1];
    
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b2 setTitle:@"change text" forState:UIControlStateNormal];
    b2.frame = CGRectMake(5, 40, 110, 30);
    b2.tag = 2;
    [b2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b2];
    
    UIButton *b3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b3 setTitle:@"change frame" forState:UIControlStateNormal];
    b3.frame = CGRectMake(5, 75, 110, 30);
    b3.tag = 3;
    [b3 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b3];
    
    UIButton *b4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b4 setTitle:@"change shadow" forState:UIControlStateNormal];
    b4.frame = CGRectMake(5, 115, 110, 30);
    b4.tag = 4;
    [b4 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b4];
    
    UIButton *b5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b5 setTitle:@"toggle shadow" forState:UIControlStateNormal];
    b5.frame = CGRectMake(5, 150, 110, 30);
    b5.tag = 5;
    [b5 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b5];
}

- (void)buttonPressed:(id)sender {
    switch ([(UIButton *)sender tag]) {
        case 1:
            styleLabel.font = [UIFont boldSystemFontOfSize:20 + arc4random() % 20];
            break;
        case 2:
            styleLabel.text = (arc4random() % 2 > 0) ? @"Alternate text: 汉语/漢語" : @"Simple Τέξτ";
            break;
        case 3:
            styleLabel.frame = CGRectMake(0, 200 + arc4random() % 100, 280, 100);
            break;
        case 4:
            [styleLabel setShadowOffset:CGSizeMake((CGFloat)(arc4random()%5), (CGFloat)(arc4random()%5)) radius:(CGFloat)(arc4random()%5)];
            break;
        case 5:
            styleLabel.hasShadow = !styleLabel.hasShadow;
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
