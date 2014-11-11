//
//  LHLLandscape.m
//  InfinityGolf
//
//  Created by Cory Alder on 2014-11-06.
//  Copyright (c) 2014 Davander Mobile Corporation. All rights reserved.
//

#import "LHLLandscape.h"
#import "LHLGameConstants.h"

#define HOLE_WIDTH 20
#define HOLE_WIDTH_2 HOLE_WIDTH/2

@implementation LHLLandscape {
    SKShapeNode *_shape;
}

-(instancetype)initWithFrame:(CGRect)rect andComplexity:(NSUInteger)complexity {
    if ((self = [super init])) {
        self.points = [NSMutableArray array];
        
        CGFloat width = rect.size.width;
        CGFloat height = rect.size.height;
        CGFloat height_2 = height/2;
        CGFloat variation = height/10;
        CGFloat segments = 20;
        CGFloat segwidth = width/segments;
        
        // define the starting platform, set self.start to the CGPoint where we're starting.
        
        CGFloat startheight = height_2 + (-variation/2 + arc4random_uniform(variation));
        
        NSValue *pt = [NSValue valueWithCGPoint:(CGPoint){ .x = 0, .y = startheight }];
         [self.points addObject:pt];
        
        _start = (CGPoint){ .x = segwidth, .y = startheight };
        NSValue *pt2 = [NSValue valueWithCGPoint:self.start];
         [self.points addObject:pt2];
        
        NSValue *pt3 = [NSValue valueWithCGPoint:(CGPoint){ .x = segwidth * 2, .y = startheight}];
        [self.points addObject:pt3];
        
        // define the random map
        
        for (int i = 3; i < segments-3; i++) {
            CGFloat x = i*segwidth;
            CGFloat y = height_2 + (-variation/2 + arc4random_uniform(variation));
            NSValue *ptnew = [NSValue valueWithCGPoint:(CGPoint){.x = x, .y = y}];
            [self.points addObject:ptnew];
        }
        
        // define the hole and hole platform
        
        CGFloat holeheight = height_2 + (-variation/2 + arc4random_uniform(variation));
        
        NSValue *holePlatformStart = [NSValue valueWithCGPoint:(CGPoint){ .x = (segments-3)*segwidth, .y = holeheight }];
        [self.points addObject:holePlatformStart];
        
        _hole = (CGRect){ ((segments-2)*segwidth)-HOLE_WIDTH_2, holeheight-HOLE_WIDTH, HOLE_WIDTH, HOLE_WIDTH};
        
        NSValue *holeLeftCorner = [NSValue valueWithCGPoint:(CGPoint){_hole.origin.x, _hole.origin.y+HOLE_WIDTH}];
        [self.points addObject:holeLeftCorner];
        
        NSValue *holeBottomLeft = [NSValue valueWithCGPoint:(CGPoint){_hole.origin.x, _hole.origin.y}];
        [self.points addObject:holeBottomLeft];
        
        NSValue *holeBottomRight = [NSValue valueWithCGPoint:(CGPoint){_hole.origin.x+HOLE_WIDTH, _hole.origin.y}];
        [self.points addObject:holeBottomRight];
        
        NSValue *holeRightCorner = [NSValue valueWithCGPoint:(CGPoint){_hole.origin.x+HOLE_WIDTH, _hole.origin.y+HOLE_WIDTH}];
        [self.points addObject:holeRightCorner];
        
        NSValue *holePlatformEnd = [NSValue valueWithCGPoint:(CGPoint){ .x = (segments-1)*segwidth, .y = holeheight }];
        [self.points addObject:holePlatformEnd];
        
        // close out the path
        NSValue *rightSide = [NSValue valueWithCGPoint:(CGPoint){.x = width, .y = height_2 + (-variation/2 + arc4random_uniform(variation))}];
        [self.points addObject:rightSide];
        
        NSValue *rightBottom = [NSValue valueWithCGPoint:(CGPoint){width, 0}];
        [self.points addObject:rightBottom];
        NSValue *leftBottom = [NSValue valueWithCGPoint:(CGPoint){0, 0}];
        [self.points addObject:leftBottom];
        
    }
    return self;
}

-(UIBezierPath *)bezierPath {
    UIBezierPath *path = [[UIBezierPath alloc] init];

    BOOL started = NO;
    
    for (NSValue *point in self.points) {
        if (started == NO) {
            started = YES;
            [path moveToPoint:[point CGPointValue]];
        } else {
            [path addLineToPoint:[point CGPointValue]];
        }
    }
    
    [path closePath];
    return path;
}

-(SKShapeNode *)shape {
    if (!_shape) {
        
        UIBezierPath *path = [self bezierPath];
        
        _shape = [SKShapeNode shapeNodeWithPath:path.CGPath];
        _shape.lineWidth = 0.0;
        _shape.fillColor = [UIColor brownColor];
        
        /* insert landscape physics body code */
    }
    return _shape;
}

@end
