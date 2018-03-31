# PXSiriWave9: Objective-C

<p align="center">
  <img src="https://raw.githubusercontent.com/prscX/PXSiriWave9/master/assets/siriwave9.gif" width="600" height="300" />
</p>


<p align="center">
  <a href="https://github.com/prscX/PXSiriWave9/pulls"><img alt="PRs Welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" /></a>
  <a href="https://github.com/prscX/PXSiriWave9#License"><img src="https://img.shields.io/npm/l/react-native-siri-wave-view.svg?style=flat" /></a>
</p>


## Getting started

- Please run below command in your app in order to install `cocoapods` required by the library:

`pod init`

`pod 'PXSiriWave', '~> 0.0'`


## Usage

```objectivec
PXSiriWave *siriWave = [[PXSiriWave alloc] initWithFrame: CGRectMake(0, 0, 1000, 1000)];
siriWave.frequency = 1.5;
siriWave.amplitude = 0.01;
siriWave.intensity = 0.3;

siriWave.colors = [NSArray arrayWithObjects: [UIColor brownColor], [UIColor blueColor], [UIColor blackColor], nil];


[siriWave configure];

[self.view addSubview: siriWave];

```

- **Start Animation**

Please setup `Timer` in order to animate waves:

```objectivec
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 0.10
    target:self
    selector: @selector(targetMethod:)
    userInfo: siriWave
    repeats:YES];

```

- **Set Timer Target**

```objectivec

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

```

- **Stop Animation**

```objectivec
[timer invalidate];
timer = NULL;
```


## Properties


| Prop              | Type       | Default | Note                                                                                                       |
| ----------------- | ---------- | ------- | ---------------------------------------------------------------------------------------------------------- |
| `amplitude`      | `number`     |    0.01     | Amplitude of Waves |
| `frequency`      | `number`     |    1.5     | Frequency of Waves |
| `intensity`      | `number`     |    0.3     | Specify intensity of wave |
| `colors`      | `array`     |    ["#2085fc", "#5efca9", "#fd4767"]     | Specify colors of siri wave 9 colors |


## Credit
- Siri Wave 9 Implementation by: [GreatPotter](https://github.com/GreatPotter)

## Contribution
Contributions are welcome and are greatly appreciated! Every little bit helps, and credit will always be given.

## License
Copyright @ Pranav Raj Singh Chauhan

PXSiriWave is provided under the Apache 2 License.


