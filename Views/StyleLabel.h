//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StyleLabel : UILabel {
    NSArray *colors;
}

@property (nonatomic, retain) NSArray *colors;

- (id)initWithText:(NSString *)aText gradientColors:(NSArray *)gradientColors;

@end
