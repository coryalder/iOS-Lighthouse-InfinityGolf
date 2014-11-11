//
//  LHLBall.m
//  InfinityGolf
//
//  Created by Cory Alder on 2014-11-06.
//  Copyright (c) 2014 Davander Mobile Corporation. All rights reserved.
//

#import "LHLBall.h"
#import "LHLGameConstants.h"

@implementation LHLBall

+ (instancetype)shapeNodeWithCircleOfRadius:(CGFloat)radius atPoint:(CGPoint)pt {
    LHLBall *ball = [super shapeNodeWithCircleOfRadius:radius];
    ball.position = pt;
    
    ball.fillColor = [UIColor whiteColor];
    ball.lineWidth = 0;
    
    /* insert ball physics code */
    
    
    return ball;
}

@end
