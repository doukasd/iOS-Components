//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StyleLabel : UILabel {
    NSArray *colors;
    
    CGFloat shadowRadius;
    CGSize  shadowOffset;
    BOOL    hasShadow;
    
    UIColor *strokeColor;
    BOOL    hasStroke;
}

@property (nonatomic, retain) NSArray *colors;
@property (nonatomic, retain) UIColor *strokeColor;

@property BOOL hasShadow, hasStroke;

- (id)initWithText:(NSString *)aText gradientColors:(NSArray *)gradientColors;
- (void)setShadowOffset:(CGSize)offset radius:(CGFloat)radius;

@end
