//
//  ViewController.m
//  PXSiriWaveExample
//
//  Created by user on 28/03/18.
//  Copyright © 2018 PX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSTimer *timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PXSiriWave *siriWave = [[PXSiriWave alloc] initWithFrame: CGRectMake(0, 0, 1000, 1000)];
//    siriWave.frequency = 1.5;
//    siriWave.amplitude = 0.01;
//    siriWave.intensity = 0.3;
//    siriWave.colors = [NSArray arrayWithObjects: [ViewController colorFromHexCode: @"#2085fc"], [ViewController colorFromHexCode: @"#5efca9"], [ViewController colorFromHexCode: @"#fd4767"], nil];
    
    [siriWave configure];
    
    [self.view addSubview: siriWave];
    
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.10
                                             target:self
                                           selector: @selector(targetMethod:)
                                           userInfo: siriWave
                                            repeats:YES];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)targetMethod:(NSTimer *)timer  {
    PXSiriWave *siriWave = [timer userInfo];
    
    [siriWave updateWithLevel: [self _normalizedPowerLevelFromDecibels: .1]];
}


- (CGFloat)_normalizedPowerLevelFromDecibels:(CGFloat)decibels {
    if (decibels < -60.0f || decibels == 0.0f) {
        return 0.0f;
    }
    
    return powf((powf(10.0f, 0.05f * decibels) - powf(10.0f, 0.05f * -60.0f)) * (1.0f / (1.0f - powf(10.0f, 0.05f * -60.0f))), 1.0f / 2.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
