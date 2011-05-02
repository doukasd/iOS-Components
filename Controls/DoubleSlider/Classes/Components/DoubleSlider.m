//
//  DoubleSlider.m
//  Sweeter
//
//  Created by Dimitris on 23/06/2010.
//  Copyright 2010 locus-delicti.com. All rights reserved.
//

#import "DoubleSlider.h"

#define kMinHandleDistance		10.0

//create the gradient
static const CGFloat colors [] = { 
	0.6, 0.6, 1.0, 1.0, 
	0.0, 0.0, 1.0, 1.0
};

//define private methods
@interface DoubleSlider (PrivateMethods)
- (void)updateValues;
- (void)addToContext:(CGContextRef)context roundRect:(CGRect)rrect withRoundedCorner1:(BOOL)c1 corner2:(BOOL)c2 corner3:(BOOL)c3 corner4:(BOOL)c4 radius:(CGFloat)radius;
- (void)updateHandleImages;
@end


@implementation DoubleSlider

@synthesize minSelectedValue, maxSelectedValue;
@synthesize minHandle, maxHandle;

- (void) dealloc
{
	CGColorRelease(bgColor);
	self.minHandle = nil;
	self.maxHandle = nil;
	[super dealloc];
}


#pragma mark Object initialization

- (id) initWithFrame:(CGRect)aFrame minValue:(float)aMinValue maxValue:(float)aMaxValue barHeight:(float)height
{
	if (self = [super initWithFrame:aFrame])
	{
		if (aMinValue < aMaxValue) {
			minValue = aMinValue;
			maxValue = aMaxValue;
		}
		else {
			minValue = aMaxValue;
			maxValue = aMinValue;
		}
		sliderBarHeight = height;
		
		self.minHandle = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"handle.png"] highlightedImage:[UIImage imageNamed:@"handle_highlight.png"]] autorelease];
		self.minHandle.center = CGPointMake(self.frame.size.width * 0.2, sliderBarHeight * 0.5);
		[self addSubview:self.minHandle];
		
		self.maxHandle = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"handle.png"] highlightedImage:[UIImage imageNamed:@"handle_highlight.png"]] autorelease];
		self.maxHandle.center = CGPointMake(self.frame.size.width * 0.8, sliderBarHeight * 0.5);
		[self addSubview:self.maxHandle];
		
		bgColor = CGColorRetain([UIColor darkGrayColor].CGColor);
		self.backgroundColor = [UIColor clearColor];
		
		//init
        latchMin = NO;
        latchMax = NO;
		[self updateValues];
	}
	return self;
}

+ (id) doubleSlider
{
	return [[[self alloc] initWithFrame:CGRectMake(0., 0., 300., 40.) minValue:1.0 maxValue:100.0 barHeight:10.0] autorelease];
}

#pragma mark Touch tracking

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    if ( CGRectContainsPoint(self.minHandle.frame, touchPoint) ) {
		latchMin = YES;
	}
	else if ( CGRectContainsPoint(self.maxHandle.frame, touchPoint) ) {
		latchMax = YES;
	}
    [self updateHandleImages];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchPoint = [touch locationInView:self];
	if ( latchMin || CGRectContainsPoint(self.minHandle.frame, touchPoint) ) {
		if (touchPoint.x < self.maxHandle.center.x - kMinHandleDistance && touchPoint.x > 0.0) {
			self.minHandle.center = CGPointMake(touchPoint.x, self.minHandle.center.y);
			[self updateValues];
		}
	}
	else if ( latchMax || CGRectContainsPoint(self.maxHandle.frame, touchPoint) ) {
		if (touchPoint.x > self.minHandle.center.x + kMinHandleDistance && touchPoint.x < self.frame.size.width) {
			self.maxHandle.center = CGPointMake(touchPoint.x, self.maxHandle.center.y);
			[self updateValues];
		}
	}
	// Send value changed alert
	[self sendActionsForControlEvents:UIControlEventValueChanged];
    
	//redraw
	[self setNeedsDisplay];
	return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    latchMin = NO;
    latchMax = NO;
    [self updateHandleImages];
}

#pragma mark Custom Drawing

- (void) drawRect:(CGRect)rect
{
	//FIX: optimise and save some reusable stuff
	
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
	
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, rect);
	
	CGRect rect1 = CGRectMake(0.0, 0.0, self.minHandle.center.x, sliderBarHeight);
	CGRect rect2 = CGRectMake(self.minHandle.center.x, 0.0, self.maxHandle.center.x - self.minHandle.center.x, sliderBarHeight);
	CGRect rect3 = CGRectMake(self.maxHandle.center.x, 0.0, self.frame.size.width - self.maxHandle.center.x, sliderBarHeight);
	
    CGContextSaveGState(context);
	
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	
	//add the right rect
	[self addToContext:context roundRect:rect3 withRoundedCorner1:NO corner2:YES corner3:YES corner4:NO radius:5.0f];
	//add the left rect
	[self addToContext:context roundRect:rect1 withRoundedCorner1:YES corner2:NO corner3:NO corner4:YES radius:5.0f];
	
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	
	CGGradientRelease(gradient), gradient = NULL;
	
	//draw middle rect
    CGContextRestoreGState(context);
	CGContextSetFillColorWithColor(context, bgColor);
	CGContextFillRect(context, rect2);
		
	[super drawRect:rect];
}

- (void)addToContext:(CGContextRef)context roundRect:(CGRect)rrect withRoundedCorner1:(BOOL)c1 corner2:(BOOL)c2 corner3:(BOOL)c3 corner4:(BOOL)c4 radius:(CGFloat)radius
{	
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, c1 ? radius : 0.0f);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, c2 ? radius : 0.0f);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, c3 ? radius : 0.0f);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, c4 ? radius : 0.0f);
}


#pragma mark Helper

- (void)updateHandleImages
{
    self.minHandle.highlighted = latchMin;
    self.maxHandle.highlighted = latchMax;
}

- (void)updateValues
{
	float span = maxValue - minValue; //FIX: this should be cached
	self.minSelectedValue = minValue + self.minHandle.center.x / self.frame.size.width * span;
	self.maxSelectedValue = minValue + self.maxHandle.center.x / self.frame.size.width * span;
}

@end