//
//  MyView.m
//  Left & Right Faces
//
//  Created by Edward Sun on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyView.h"
//#import "ViewController.h"

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    const CGFloat length[] = {8, 8, 8, 8};
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetLineDash(context, 0, length, 4);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, CGPointMake(160, 0).x, CGPointMake(160, 0).y); 
    CGContextAddLineToPoint(context, CGPointMake(160, 436).x, CGPointMake(160, 436).y); 
    CGContextStrokePath(context);
}


@end
