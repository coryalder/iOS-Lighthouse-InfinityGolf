//
//  LHLBall.h
//  InfinityGolf
//
//  Created by Cory Alder on 2014-11-06.
//  Copyright (c) 2014 Davander Mobile Corporation. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LHLBall : SKShapeNode

@property (readwrite) BOOL struck;

+ (instancetype)shapeNodeWithCircleOfRadius:(CGFloat)radius atPoint:(CGPoint)pt;

@end
