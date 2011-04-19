//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import "GlowLabel.h"

#define GLOW_OFFSET     CGSizeZero
#define GLOW_RADIUS     10


@implementation GlowLabel

@synthesize selectedColor, unselectedColor;

- (void)dealloc {
    self.selectedColor = nil;
    self.unselectedColor = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = UITextAlignmentCenter;
        self.font = [UIFont fontWithName:@"Digital-7" size:60];
        self.backgroundColor = [UIColor clearColor];
        
        //initialize with default colors
        self.selectedColor = [UIColor greenColor];
        self.unselectedColor = [UIColor grayColor];
        //init as unselected
        selected = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)isSelected {
    selected = isSelected;
    self.textColor = (selected ? self.selectedColor : self.unselectedColor);
    [self setNeedsDisplay];
}

- (BOOL)selected {
    return selected;
}

- (void)drawTextInRect:(CGRect)rect
{
    if (selected) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetShadowWithColor(context, GLOW_OFFSET, GLOW_RADIUS, [self.selectedColor CGColor]);
    }
	[super drawTextInRect:rect];
}

@end
