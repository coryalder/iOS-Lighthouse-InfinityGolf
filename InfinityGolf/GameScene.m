//
//  GameScene.m
//  InfinityGolf
//
//  Created by Cory Alder on 2014-11-06.
//  Copyright (c) 2014 Davander Mobile Corporation. All rights reserved.
//

#import "GameScene.h"

#import "LHLGameConstants.h"
#import "LHLLandscape.h"
#import "LHLBall.h"

@implementation GameScene

#define BALL_RADIUS 5.0f

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    [super didMoveToView:view];
    
    /* insert physics world and delgate code */
    
    self.physicsWorld.speed = 0.7;
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    
    self.physicsWorld.contactDelegate = self;
    self.physicsBody.categoryBitMask = LHLGameCategoryWorld;
//    
//    self.physicsBody.collisionBitMask =
    
    [self setupLabels];
    [self resetLandscape];
}


-(void)didBeginContact:(SKPhysicsContact *)contact {
    
    if (contact.bodyA == self.physicsBody || contact.bodyB == self.physicsBody) {
        [self resetBall];
    }

    //NSLog(@"Contact between %@ and %@", contact.bodyA, contact.bodyB);
    
}



-(void)setupLabels {
    self.strokeLabel = [SKLabelNode labelNodeWithText:@"0"];
    self.strokeLabel.fontName = @"HelveticaNeue-Bold";
    CGPoint pt = [self.view convertPoint:(CGPoint){self.strokeLabel.frame.size.width,self.strokeLabel.frame.size.height} toScene:self];
    self.strokeLabel.position = pt;
    [self addChild:self.strokeLabel];
    
    self.courseLabel = [SKLabelNode labelNodeWithText:@"0"];
    self.courseLabel.fontName = @"HelveticaNeue-Bold";
    CGPoint pt2 = [self.view convertPoint:(CGPoint){self.view .frame.size.width - self.courseLabel.frame.size.width,self.courseLabel.frame.size.height} toScene:self];
    self.courseLabel.position = pt2;
    [self addChild:self.courseLabel];
    
    self.averageLabel = [SKLabelNode labelNodeWithText:@"0"];
    self.averageLabel.fontName = @"HelveticaNeue-Bold";
    CGPoint pt3 = [self.view convertPoint:(CGPoint){(self.view .frame.size.width/2) - (self.averageLabel.frame.size.width/2),self.averageLabel.frame.size.height} toScene:self];
    self.averageLabel.position = pt3;
    
    [self addChild:self.averageLabel];
}

-(void)resetLandscape {
    [self.landscape.shape removeFromParent];
    
    self.landscape = [[LHLLandscape alloc] initWithFrame:(CGRect){0,0, .size = self.size} andComplexity:0];
    
    SKShapeNode *landShape = [self.landscape shape];
    [self addChild:landShape];
    
    self.courseCount++;
    
    [self resetBall];
}

-(void)resetBall {
    
    [self.ball removeFromParent];
    
    CGPoint pos = (CGPoint){self.landscape.start.x, self.landscape.start.y + BALL_RADIUS};
    self.ball = [LHLBall shapeNodeWithCircleOfRadius:BALL_RADIUS atPoint:pos];
    
    [self addChild:self.ball];
}

#pragma mark - Game Loop


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    self.strokeLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.strokeCount];
    self.courseLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.courseCount];
    self.averageLabel.text = [NSString stringWithFormat:@"%0.1f", (float)self.strokeCount/(float)self.courseCount];
    
    /* Ball-in-hole detection */
    
    CGVector vel = self.ball.physicsBody.velocity;
    CGFloat integrated = fabs(vel.dx+vel.dy);
    
    if (self.ball.struck && (integrated < 0.01)) {
        // ball is stopped.
        if (CGRectContainsPoint(self.landscape.hole, self.ball.position)) {
            
            
            SKAction *boop = [SKAction playSoundFileNamed:@"yay.wav" waitForCompletion:NO];
            
            [self runAction:boop completion:^{
                [self resetLandscape];
            }];
        }
    }

}


#pragma mark - User Interaction

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    self.start = [[touches anyObject] locationInNode:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // update visual feedback of stroke stength
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint end = [touch locationInNode:self];
    CGFloat xDist = end.x - self.start.x;
    CGFloat yDist = end.y - self.start.y;
    
    //CGFloat dist = sqrt((xDist * xDist) + (yDist * yDist)); // check for under max dist. and ignore if it's too weak a shot
    
    [self strikeBall:(CGVector){-xDist/1000, -yDist/1000}];
}

#pragma mark - actions

-(void)strikeBall:(CGVector)vector {
    /* insert strike ball code */
    
    SKAction *boop = [SKAction playSoundFileNamed:@"hit.wav" waitForCompletion:NO];
    
    [self.ball runAction:boop completion:^{
        self.ball.struck = YES;
        self.strokeCount++;
        [self.ball.physicsBody applyImpulse:vector];
    }];

}


@end
