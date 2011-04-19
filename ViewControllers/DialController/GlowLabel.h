//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GlowLabel : UILabel {
    BOOL selected;
    UIColor *selectedColor;
    UIColor *unselectedColor;
}

@property (nonatomic, retain) UIColor *selectedColor;
@property (nonatomic, retain) UIColor *unselectedColor;

- (void)setSelected:(BOOL)isSelected;
- (BOOL)selected;


@end
