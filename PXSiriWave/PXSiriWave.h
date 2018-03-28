//
//  PXSiriWave.h
//  PXSiriWave
//
//  Created by Pranav Raj Singh Chauhan on 28/03/18.
//  Copyright © 2018 PX. All rights reserved.
//

@import UIKit;

IB_DESIGNABLE
@interface PXSiriWave : UIView

/*
 * Tells the waveform to redraw itself using the given level (normalized value)
 */
- (void)updateWithLevel:(CGFloat)level;
- (void)configure;


@property (nonatomic, strong) IBInspectable NSArray *colors;

@property (nonatomic, assign)  IBInspectable CGFloat intensity;

@property (nonatomic, assign) IBInspectable CGFloat frequency;

@property (nonatomic, assign) IBInspectable CGFloat amplitude;

@end
