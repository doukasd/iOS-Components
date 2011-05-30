//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import "StyleLabel.h"
#import "UIColor-Expanded.h"

#define GLOW_OFFSET     CGSizeMake(1, 2)
#define GLOW_RADIUS     4

@interface StyleLabel (PrivateMethods)
- (UIImage *)gradientImageWithColors:(NSArray *)colors;
- (void)redrawLabel;
@end


@implementation StyleLabel

@synthesize colors;

- (void)dealloc {
    self.colors = nil;
    [super dealloc];
}

- (id)initWithText:(NSString *)aText gradientColors:(NSArray *)gradientColors {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.colors = gradientColors;
        self.text = aText;
        
        [self redrawLabel];
    }
    return self;
}

- (void)redrawLabel {
    //calculate frame
    CGSize textSize = [self.text sizeWithFont:self.font];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, textSize.width, textSize.height);
    
    //draw gradient
    if (!CGRectEqualToRect(self.frame, CGRectZero)) {
        self.textColor = [UIColor colorWithPatternImage:[self gradientImageWithColors:self.colors]];
    }
}

#pragma mark Override setters

- (void)setFont:(UIFont *)font {
    //set font
    [super setFont:font];
    //re-create color gradient for the new size
    [self redrawLabel];
    //re-draw text
    //[self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self redrawLabel];
    //re-draw text
    //self.frame = self.frame;
}
/*
- (void)setFrame:(CGRect)frame {
    [self redrawLabel];
    //then center it to the new frame - actually we are not allowing the frame to be set, this just moves the label
    self.center = CGPointMake(frame.origin.x + frame.size.width * 0.5, frame.origin.y + frame.size.height * 0.5);
}
*/
#pragma mark -

- (UIImage *)gradientImageWithColors:(NSArray *)gradientColors
{
    //get the size of the label
    CGSize textSize = [self.text sizeWithFont:self.font];
    CGFloat width = textSize.width;         // max 1024 due to Core Graphics limitations
    CGFloat height = textSize.height;       // max 1024 due to Core Graphics limitations
    
    NSAssert(width <= 1024.0 && height <= 1024.0, @"Label dimensions should not exceed 1024 on any axis. Could work, but results might be unexpected");
        
    // create a new bitmap image context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    // get context
    CGContextRef context = UIGraphicsGetCurrentContext();		
    
    // push context to make it current (need to do this manually because we are not drawing in a UIView)
    UIGraphicsPushContext(context);
    
    //draw gradient    
    CGGradientRef gradient;
    CGColorSpaceRef rgbColorspace;
    
    //set uniform distribution of color locations
    size_t num_locations = [gradientColors count];
    CGFloat locations[num_locations];
    for (int k=0; k<num_locations; k++) {
        locations[k] = k / (CGFloat)(num_locations - 1); //we need the locations to start at 0.0 and end at 1.0, equaly filling the domain
    }

    //create c array from color array
    CGFloat components[num_locations * 4];
    for (int i=0; i<num_locations; i++) {
        UIColor *color = [gradientColors objectAtIndex:i];
        NSAssert(color.canProvideRGBComponents, @"Color components could not be extracted from StyleLabel gradient colors.");
        components[4*i+0] = color.red;
        components[4*i+1] = color.green;
        components[4*i+2] = color.blue;
        components[4*i+3] = color.alpha;
    }
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    CGPoint topCenter = CGPointMake(0, 0);
    CGPoint bottomCenter = CGPointMake(0, height);
    CGContextDrawLinearGradient(context, gradient, topCenter, bottomCenter, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(rgbColorspace); 
    
    // pop context 
    UIGraphicsPopContext();								
    
    // get a UIImage from the image context
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // clean up drawing environment
    UIGraphicsEndImageContext();
    
    return  gradientImage;
}

- (void)drawTextInRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //draw stroke
    //CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetTextDrawingMode (context, kCGTextFillStroke);
    
    //draw shadow
    CGContextSetShadowWithColor(context, GLOW_OFFSET, GLOW_RADIUS, [[UIColor blackColor] CGColor]);    

	[super drawTextInRect:rect];

}

@end