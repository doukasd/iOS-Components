//
//  DoubleSlider.h
//  Sweeter
//
//  Created by Dimitris on 23/06/2010.
//  Copyright 2010 locus-delicti.com. All rights reserved.
//


@interface DoubleSlider : UIControl {
	float minSelectedValue;
	float maxSelectedValue;
	float minValue;
	float maxValue;
    BOOL latchMin;
    BOOL latchMax;
	
	UIImageView *minHandle;
	UIImageView *maxHandle;
	
	float sliderBarHeight;
	
	CGColorRef bgColor;
}

@property float minSelectedValue;
@property float maxSelectedValue;

@property (nonatomic, retain) UIImageView *minHandle;
@property (nonatomic, retain) UIImageView *maxHandle;

- (id) initWithFrame:(CGRect)aFrame minValue:(float)minValue maxValue:(float)maxValue barHeight:(float)height;
+ (id) doubleSlider;

@end


/*
Improvements:
 - initWithWidth instead of frame?
 - do custom drawing below an overlay layer
*/