//
//  Created by Dimitris Doukas on 25/03/2011.
//  Copyright 2011 doukasd.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DialControllerDelegate;

@interface DialController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *tableView;
    BOOL isSpinning;    //refers to wether the user is spinning it
    BOOL isAnimating;   //refers to wether it is animating into position
    NSArray *strings;
    NSInteger selectedStringIndex;
    NSString *selectedString;
    id<DialControllerDelegate> delegate;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *strings;

@property (nonatomic, copy) NSString *selectedString;

@property (readonly) NSInteger selectedStringIndex;
@property BOOL isSpinning;

@property (nonatomic, assign) id<DialControllerDelegate> delegate;

- (id)initWithDialFrame:(CGRect)frame strings:(NSArray *)dialStrings;
- (void)spinToRandomString;
- (void)spinToString:(NSString *)string;

@end


@protocol DialControllerDelegate <NSObject>
- (void)dialControllerDidSpin:(DialController *)controller;
@required
- (void)dialController:(DialController *)dial didSnapToString:(NSString *)string;
@end