//
//  DDURLParser.h
//
//
//  Created by Dimitris Doukas on 09/02/2010.
//  Copyright 2010 doukasd.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDURLParser : NSObject {
    NSArray *variables;
}

@property (nonatomic, retain) NSArray *variables;

- (id)initWithURLString:(NSString *)url;
- (NSString *)valueForVariable:(NSString *)varName;

@end