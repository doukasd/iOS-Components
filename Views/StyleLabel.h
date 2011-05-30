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
}

@property (nonatomic, retain) NSArray *colors;

@property BOOL hasShadow;

- (id)initWithText:(NSString *)aText gradientColors:(NSArray *)gradientColors;
- (void)setShadowOffset:(CGSize)offset radius:(CGFloat)radius;

@end
