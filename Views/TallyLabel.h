//
//  TallyLabel.h
//
//  Created by Dimitris Doukas on 05/05/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TallyLabel : UILabel {
    NSString *stringFormat;
    CGFloat animationDuration;
    
@private  
    NSTimer *timer;
    NSInteger textNumber;
    float currentTextNumber;
    float currentStep;
}

//public properties
@property (nonatomic, copy) NSString *stringFormat;
@property CGFloat animationDuration;

@end