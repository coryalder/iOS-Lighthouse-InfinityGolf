//
//  GameScene.h
//  InfinityGolf
//

//  Copyright (c) 2014 Davander Mobile Corporation. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class LHLLandscape, LHLBall;

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) LHLLandscape *landscape;
@property (nonatomic, strong) LHLBall *ball;

@property (nonatomic, strong) SKLabelNode *strokeLabel;
@property (nonatomic, strong) SKLabelNode *courseLabel;
@property (nonatomic, strong) SKLabelNode *averageLabel;

@property (readwrite) CGPoint start;
@property (readwrite) NSUInteger strokeCount;
@property (readwrite) NSUInteger courseCount;

@end
