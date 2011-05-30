//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import "StyleLabel.h"

#define GLOW_OFFSET     CGSizeZero
#define GLOW_RADIUS     10


@implementation StyleLabel


- (void)dealloc {
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
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
