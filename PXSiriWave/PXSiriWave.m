//
//  PXSiriWave.m
//  PXSiriWave
//
//  Created by user on 28/03/18.
//  Copyright © 2018 PX. All rights reserved.
//


#import "PXSiriWave.h"
#import "SiriWaveCurve.h"
#import "math.h"

static const CGFloat kDefaultFrequency          = 1.5f;
static const CGFloat kDefaultAmplitude          = 0.1f;
static const CGFloat kDefaultIntensity          = 0.3f;
static NSArray *kDefaultColors;

@interface PXSiriWave ()

@property (nonatomic) NSMutableArray *curves;

@end

@implementation PXSiriWave

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        kDefaultColors = [NSArray arrayWithObjects: [UIColor brownColor], [UIColor blueColor], [UIColor blackColor], nil];
        
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.frequency = kDefaultFrequency;
    self.amplitude = kDefaultAmplitude;
    self.intensity = kDefaultIntensity;
    self.colors = kDefaultColors;
}

-(void)configure {
    self.curves = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _colors.count; i++) {
        for (int j = 0; j < 3 * ((float)rand() / RAND_MAX) + 1; j++) {
            [self.curves addObject:[[SiriWaveCurve alloc] init]];
        }
    }
}

- (void)updateWithLevel:(CGFloat)level {
    CGFloat speed = 0.1;
    if (fabs(self.amplitude - _intensity) < speed) {
        self.amplitude = _intensity;
    } else {
        if (self.amplitude < _intensity) {
            self.amplitude += speed;
        } else {
            self.amplitude -= speed;
        }
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, self.bounds);
    
    [self.backgroundColor set];
    CGContextFillRect(context, rect);
    
    if (!self.curves) return;
    
    CGFloat height2 = CGRectGetHeight(self.bounds) / 2.0f;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat width2 = width / 2.0f;
    CGFloat width4 = width / 4.0f;
    
    for (int i = 0; i < self.curves.count; i++) {
        context = UIGraphicsGetCurrentContext();
        CGMutablePathRef path = CGPathCreateMutable();
        CGContextSaveGState(context);
        
        [self.curves[i] changeTick];
        
        const CGFloat maxAmplitude = height2 - 2;
        
        SiriWaveCurve *curve = self.curves[i];
        CGFloat xBase = width2 + (-width4 + curve.seed * width2);
        CGFloat yBase = height2;
        
        CGFloat t_amplitude = (float) (_amplitude / (fabs(width2 - xBase) / width4 + 0.5));
        
        CGFloat x, y, xInit = 10000000;
        for (CGFloat j = -3; j <= 3; j += 0.01) {
            x = xBase + j * width4;
            y = yBase + [self.curves[i] _ypos:j  amplitude:t_amplitude maxAmplitude:maxAmplitude];
            
            xInit = fmin(xInit, x);
            
            if (j == -3) {
                CGPathMoveToPoint(path, NULL, x, y);
            } else {
                CGPathAddLineToPoint(path, NULL, x, y);
            }
        }
        CGPathAddLineToPoint(path, NULL, xInit, yBase);
        
        xInit = 10000000;
        for (CGFloat j = -3; j <= 3; j += 0.01) {
            x = xBase + j * width4;
            y = yBase - [self.curves[i] _ypos:j  amplitude:t_amplitude maxAmplitude:maxAmplitude];
            
            xInit = fmin(xInit, x);
            
            if (j == -3) {
                CGPathMoveToPoint(path, NULL, x, y);
            } else {
                CGPathAddLineToPoint(path, NULL, x, y);
            }
        }
        
        CGFloat h = fabs([curve _ypos:0 amplitude:self.amplitude maxAmplitude:maxAmplitude]);
        
        CGPathAddLineToPoint(path, NULL, xInit, yBase);
        
        CGContextAddPath(context, path);
        CGContextClip(context);
        
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        UIColor *color = self.colors[i%3];
        const CGFloat *col = CGColorGetComponents( color.CGColor );
        CGFloat components[] = {
            col[0], col[1], col[2], 1.0f,
            col[0], col[1], col[2], 0.2f,
        };
        CGFloat locations[] = {0, 1};
        CGPoint center = CGPointMake(xBase, yBase);
        
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, 2);
        CGContextDrawRadialGradient(context, gradient, center, width2 , center, h * 0.3, kCGGradientDrawsAfterEndLocation);
        
        CGContextRestoreGState(context);
        
        CGPathRelease(path);
        CGColorSpaceRelease(colorSpaceRef);
        CGGradientRelease(gradient);
    }
}

@end

