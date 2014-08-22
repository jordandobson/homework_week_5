//
//  JRDRandomPercentGenerator.m
//  DrawingBoard
//
//  Created by Jordan Dobson on 8/21/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDRandomPercentGenerator.h"

@implementation JRDRandomPercentGenerator
+(NSArray*)arrayOfPercents:(NSUInteger)count
{
    NSAssert(count > 0, @"Must have a count greater than zero");

    NSMutableArray *numbers = [NSMutableArray new];
    while (numbers.count < count) {
        NSNumber *singleNumber = @( arc4random_uniform(1000) / 1000.0 );
        [numbers addObject:singleNumber];
    }
    return [NSArray arrayWithArray:numbers];
}
@end
