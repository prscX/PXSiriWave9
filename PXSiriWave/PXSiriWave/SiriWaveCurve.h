//
//  SiriWaveCurve.h
//  PXSiriWave
//
//  Created by user on 28/03/18.
//  Copyright © 2018 PX. All rights reserved.
//


@import UIKit;
#import <Foundation/Foundation.h>
#import "PXSiriWave.h"

@class SCSiriWaveformView;

@interface SiriWaveCurve : NSObject

@property (nonatomic, assign) CGFloat tick;
@property (nonatomic, assign) CGFloat amplitude;
@property (nonatomic, assign) CGFloat seed;
@property (nonatomic, assign) CGFloat openClass;

- (void)respawn;

- (CGFloat)_ypos:(CGFloat)i amplitude:(CGFloat)amplitude maxAmplitude:(CGFloat)maxAmplitude;

- (void)changeTick;

@end
