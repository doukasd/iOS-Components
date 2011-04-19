//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import "MultiDialViewController.h"
#import "GlowLabel.h"
#import "DialController.h"

#define DIAL_OFFSET_X               40
#define DIAL_OFFSET_Y               0
#define DIAL_WIDTH                  60
#define DIAL_HEIGHT                 100


@implementation MultiDialViewController

@synthesize presetStrings, delegate;
@synthesize dial1, dial2, dial3, dial4;


- (void)viewDidLoad {
    [super viewDidLoad];
        
    //subscribe to accelerometer calls
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/60.0];
        
    //add dials and populate with these values...
    NSArray *numbers = [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    NSArray *letters = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", nil];
    int dialCount = 0;
   
    self.dial1 = [[[DialController alloc] initWithDialFrame:CGRectMake(DIAL_OFFSET_X + dialCount++ * DIAL_WIDTH, DIAL_OFFSET_Y, DIAL_WIDTH, DIAL_HEIGHT) strings:numbers] autorelease];
    self.dial1.delegate = self;
    [self.view addSubview:self.dial1.view];
    
    self.dial2 = [[[DialController alloc] initWithDialFrame:CGRectMake(DIAL_OFFSET_X + dialCount++ * DIAL_WIDTH, DIAL_OFFSET_Y, DIAL_WIDTH, DIAL_HEIGHT) strings:numbers] autorelease];
    self.dial2.delegate = self;
    [self.view addSubview:self.dial2.view];
    
    self.dial3 = [[[DialController alloc] initWithDialFrame:CGRectMake(DIAL_OFFSET_X + dialCount++ * DIAL_WIDTH, DIAL_OFFSET_Y, DIAL_WIDTH, DIAL_HEIGHT) strings:numbers] autorelease];
    self.dial3.delegate = self;
    [self.view addSubview:self.dial3.view];
    
    self.dial4 = [[[DialController alloc] initWithDialFrame:CGRectMake(DIAL_OFFSET_X + dialCount++ * DIAL_WIDTH, DIAL_OFFSET_Y, DIAL_WIDTH, DIAL_HEIGHT) strings:letters] autorelease];
    self.dial4.delegate = self;
    [self.view addSubview:self.dial4.view];
    
    //add on overlay image
    UIImageView *overlayView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlay.png"]] autorelease];
    overlayView.center = CGPointMake(self.dial2.view.frame.origin.x + self.dial2.view.frame.size.width, self.dial1.view.center.y);
    [self.view addSubview:overlayView];

    //select initial value
    [self spinToRandomString:NO];
}

- (void)viewDidUnload {
    self.presetStrings = nil;
    self.delegate = nil;
    [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
    [super viewDidUnload];
}

//spin to random string
//is "preset" is true, spin to random preset string
- (void)spinToRandomString:(BOOL)preset {
    if (preset && self.presetStrings != nil) {
        //spin to preset
        int selectedStringIndex = random() % [self.presetStrings count];
        NSString *selectedString = [self.presetStrings objectAtIndex:selectedStringIndex];
        NSLog(@"autoselecting string %@", selectedString);
        
        //call all the dials
        [self.dial1 spinToString:[selectedString substringWithRange:NSMakeRange(0, 1)]];
        [self.dial2 spinToString:[selectedString substringWithRange:NSMakeRange(1, 1)]];
        [self.dial3 spinToString:[selectedString substringWithRange:NSMakeRange(2, 1)]];
        [self.dial4 spinToString:[selectedString substringWithRange:NSMakeRange(3, 1)]];
    }
    else {
        //spin to random
        [self.dial1 spinToRandomString];
        [self.dial2 spinToRandomString];
        [self.dial3 spinToRandomString];
        [self.dial4 spinToRandomString];
    }
}

#pragma mark DialControllerDelegate methods

- (void)dialControllerDidSpin:(DialController *)dial {
    //...
}

- (void)dialController:(DialController *)dial didSnapToString:(NSString *)value {
    NSLog(@"%@>%@", [self class], NSStringFromSelector(_cmd));
    
    if (!self.dial1.isSpinning && !self.dial2.isSpinning && !self.dial3.isSpinning && !self.dial4.isSpinning) {
        NSString *selectedString = [NSString stringWithFormat:@"%@%@%@%@", self.dial1.selectedString, self.dial2.selectedString, self.dial3.selectedString, self.dial4.selectedString];
        
        NSLog(@"selected string = %@", selectedString);
        
        //if our preset strings are not nil, we want to snap to those
        if (self.presetStrings != nil) {
            //check if the string is part of our strings
            int stringIndex = -1;
            for (int i=0; i<[self.presetStrings count]; i++) {
                if ([(NSString *)[self.presetStrings objectAtIndex:i] isEqualToString:selectedString]) {
                    stringIndex = i;
                    break;
                }
            }
            if (stringIndex > -1) {
                //if the selected string was in the presets, select it
                [[self delegate] multiDialViewController:self didSelectString:selectedString];
            }
            else {
                //if it wasn't, spin to one of the presets
                [self spinToRandomString:YES];
            }
        }
        else {
            //select that string
            [[self delegate] multiDialViewController:self didSelectString:selectedString];
        }
    }
}

#pragma mark -

//add shake to spin to random value
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	if (fabs(acceleration.x) + fabs(acceleration.y) + fabs(acceleration.z) > 4.0) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(spinToRandomYear) object:nil];
        [self performSelector:@selector(spinToRandomString:) withObject:nil afterDelay:0.5];
    }
}

#pragma -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    self.presetStrings = nil;
    self.dial1 = self.dial2 = self.dial3 = self.dial4 = nil;
    [super dealloc];
}

@end