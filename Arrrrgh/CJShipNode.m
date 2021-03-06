//
//  CJShipNode.m
//  Arrrrgh
//
//  Created by Shane Vitarana on 4/8/14.
//  Copyright (c) 2014 CrimsonJet. All rights reserved.
//

#import "CJShipNode.h"

#define kShipTurnAngle    M_PI/20.0
#define kShipMoveDistance 16.0

@interface CJShipNode () {
    
    CGFloat _angle;
    CGFloat _distance;
}

@end

@implementation CJShipNode

- (void)moveLeft {
    _angle = -kShipTurnAngle;
    _distance = -kShipMoveDistance;
    [self move];
}

- (void)moveRight {
    _angle = kShipTurnAngle;
    _distance = kShipMoveDistance;
    [self move];
}

#pragma mark - Internal Methods

- (void)move {
    SKAction *rotate     = [SKAction rotateByAngle:-_angle duration:0.1];
    SKAction *undoRotate = [SKAction rotateByAngle:_angle duration:0.1];
    
    CGVector directionVector = CGVectorMake(_distance * cosf(_angle), 0.0);
    SKAction *moveAcross = [SKAction moveBy:directionVector duration:0.25];
    SKAction *moveUp     = [SKAction moveByX:0.0 y:kShipMoveDistance duration:0.25];
    SKAction *sound      = [SKAction playSoundFileNamed:@"woosh-01-stereo-withoutsubbass.wav" waitForCompletion:NO];
    
    SKAction *group    = [SKAction group:@[rotate, moveAcross, moveUp, sound]];
    SKAction *sequence = [SKAction sequence:@[group, undoRotate]];
    
    [self runAction:sequence];
}

@end
