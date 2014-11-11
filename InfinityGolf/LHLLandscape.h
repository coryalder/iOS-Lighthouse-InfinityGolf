//
//  LHLLandscape.h
//  InfinityGolf
//
//  Created by Cory Alder on 2014-11-06.
//  Copyright (c) 2014 Davander Mobile Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface LHLLandscape : NSObject

@property (nonatomic, strong) NSMutableArray *points;

@property (readonly) CGPoint start;
@property (readonly) CGRect hole;

-(instancetype)initWithFrame:(CGRect)frame andComplexity:(NSUInteger)complexity;

-(UIBezierPath *)bezierPath;
-(SKShapeNode *)shape;

@end
