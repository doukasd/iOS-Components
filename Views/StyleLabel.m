//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import "StyleLabel.h"
#import "UIColor-Expanded.h"

@interface StyleLabel (PrivateMethods)
- (UIImage *)gradientImageWithColors:(NSArray *)colors size:(CGSize)size;
- (void)redrawLabel;
@end


@implementation StyleLabel

@synthesize colors;

- (void)dealloc {
    self.colors = nil;
    self.strokeColor = nil;
    [super dealloc];
}

- (id)initWithText:(NSString *)aText gradientColors:(NSArray *)gradientColors {
    self = [super init];
    if (self) {
        //initialize common properties
        self.hasStroke = NO;
        self.strokeColor = [UIColor blackColor];
        
        self.hasShadow = YES;
        shadowRadius = 4;
        shadowOffset = CGSizeMake(1, 2);
        
        self.backgroundColor = [UIColor clearColor];
        self.colors = gradientColors;
        self.text = aText;
        
        [self redrawLabel];
    }
    return self;
}

- (void)redrawLabel {
    //calculate and update frame
    CGSize textSize = [self.text sizeWithFont:self.font];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, textSize.width + shadowRadius, textSize.height + shadowRadius);
    
    //draw gradient
    if (!CGRectEqualToRect(self.frame, CGRectZero)) {
        self.textColor = [UIColor colorWithPatternImage:[self gradientImageWithColors:self.colors size:textSize]];
    }
}

#pragma mark Overriden/custom setters/getters

- (BOOL)hasStroke {
    return hasStroke;
}

- (void)setHasStroke:(BOOL)stroke {
    hasStroke = stroke;
    [self setNeedsDisplay];
}

- (UIColor *)strokeColor {
    return strokeColor;
}

- (void)setStrokeColor:(UIColor *)color {
    [strokeColor release];
    strokeColor = [color retain];
    //enable/disable stroke
    self.hasStroke = (strokeColor == nil);
}

- (BOOL)hasShadow {
    return hasShadow;
}

- (void)setHasShadow:(BOOL)shadow {
    hasShadow = shadow;
    if(self.hasShadow) [self redrawLabel];
    [self setNeedsDisplay];
}

- (void)setShadowOffset:(CGSize)offset radius:(CGFloat)radius {
    shadowOffset = offset;
    shadowRadius = radius;
    //enable shadow
    self.hasShadow = YES;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self redrawLabel];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self redrawLabel];
}

- (void)setFrame:(CGRect)aFrame {
    //calculate and update frame
    CGSize textSize = [self.text sizeWithFont:self.font];
    CGRect frame = CGRectMake(aFrame.origin.x, aFrame.origin.y, textSize.width + shadowRadius, textSize.height + shadowRadius);
    [super setFrame:frame];
    
    //draw gradient
    if (!CGRectEqualToRect(self.frame, CGRectZero)) {
        self.textColor = [UIColor colorWithPatternImage:[self gradientImageWithColors:self.colors size:textSize]];
    }
}

#pragma mark -

- (UIImage *)gradientImageWithColors:(NSArray *)gradientColors size:(CGSize)size
{
    CGFloat width = size.width;         // max 1024 due to Core Graphics limitations
    CGFloat height = size.height;       // max 1024 due to Core Graphics limitations
    
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
    
    //draw shadow
    if (self.hasShadow) CGContextSetShadowWithColor(context, shadowOffset, shadowRadius, [[UIColor blackColor] CGColor]); 
    
    //draw stroke
    if (self.hasStroke) {
        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
        CGContextSetTextDrawingMode(context, kCGTextFillStroke);
    }
    
	[super drawTextInRect:rect];
}

@end