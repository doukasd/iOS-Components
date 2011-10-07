//
//  CountingLabel.m
//
//  Created by Dimitris Doukas on 05/05/2011.
//  Copyright 2011 unit9.com. All rights reserved.
//

#import "CountingLabel.h"

#define kTimerInterval      0.03f


@interface CountingLabel ()
@property (nonatomic, retain) NSTimer *timer;
- (void)commonInit;
- (void)countTo:(CGFloat)number;
@end


@implementation CountingLabel

@synthesize timer, stringFormat;
@synthesize animationDuration;

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
    self.stringFormat = nil;
    [super dealloc];
}

#pragma mark Initialization

- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    textNumber = 0;
    currentTextNumber = 0.0f;
    currentStep = 0.0f;
    self.stringFormat = self.text;
    self.animationDuration = 1.0f;
}

#pragma mark -

- (void)startTimer
{
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kTimerInterval target:self selector:@selector(timerLoop:) userInfo:nil repeats:YES];
}

- (void)timerLoop:(NSTimer *)aTimer {
    //update current value
    currentTextNumber += currentStep;
    //check if the timer needs to be disabled
    if ( (currentStep >= 0 && currentTextNumber >= textNumber) || (currentStep < 0 && currentTextNumber <= textNumber) ) {
        currentTextNumber = textNumber;
        [self.timer invalidate];
    }
    
    //update the label using the specified format
    int value = (int)currentTextNumber;
    char *arg = (char *)malloc(sizeof(int));
    memcpy(arg, &value, sizeof(int));
    //call the superclass to show the appropriate text
    [super setText:[[[NSString alloc] initWithFormat:self.stringFormat arguments:arg] autorelease]];
    free(arg);
}

- (void)countTo:(CGFloat)number {
    textNumber = number;
    currentStep = (textNumber - currentTextNumber)*kTimerInterval/self.animationDuration;
    [self startTimer];
}

#pragma mark Overrides

- (void)setText:(NSString *)text
{
    //override this method to get the value and start counting
    [self countTo:[text floatValue]];
}

@end
