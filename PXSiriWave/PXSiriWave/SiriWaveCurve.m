//
//  SiriWaveCurve.m
//  PXSiriWave
//
//  Created by user on 28/03/18.
//  Copyright © 2018 PX. All rights reserved.
//


#import "SiriWaveCurve.h"

@implementation SiriWaveCurve

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tick = 0;
    }
    return self;
}

- (void)respawn {
    self.amplitude = 0.3 + (float)rand() / RAND_MAX * 0.7;
    self.seed = (float)rand() / RAND_MAX;
    self.openClass = 2 + floorf(((CGFloat)rand() / RAND_MAX)*3);
}

- (CGFloat)_ypos:(CGFloat)i amplitude:(CGFloat)amplitude maxAmplitude:(CGFloat)maxAmplitude {
    CGFloat p = self.tick;
    CGFloat y = -1 * fabs(sin(p)) * amplitude * _amplitude * maxAmplitude * pow(1 / (1 + pow(self.openClass * i, 2)), 2);
    
    if (fabs(y) < 0.001) {
        [self respawn];
    }
    
    return y;
}

- (void)changeTick {
    self.tick += 0.2 * (1 - 0.5 * sin(self.seed * M_PI));
}

@end
