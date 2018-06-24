<h1 align="center">

<p align="center">
  <a href="https://github.com/prscX/PXSiriWave9/pulls"><img alt="PRs Welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" /></a>
  <a href="https://github.com/prscX/PXSiriWave9#License"><img src="https://img.shields.io/npm/l/react-native-siri-wave-view.svg?style=flat" /></a>
</p>

    PXSiriWave9: Objective-C

If this project has helped you out, please support us with a star 🌟
</h1>


| |
| ----------------- |
| <img src="https://raw.githubusercontent.com/prscX/PXSiriWave9/master/assets/siriwave9.gif" />                  |


## 📖 Getting started

- Please run below command in your app in order to install `cocoapods` required by the library:

`pod init`

`pod 'PXSiriWave', '~> 0.0.2'`


## 💻 Usage

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


## 💡 Properties


| Prop              | Type       | Default | Note                                                                                                       |
| ----------------- | ---------- | ------- | ---------------------------------------------------------------------------------------------------------- |
| `amplitude`      | `number`     |    0.01     | Amplitude of Waves |
| `frequency`      | `number`     |    1.5     | Frequency of Waves |
| `intensity`      | `number`     |    0.3     | Specify intensity of wave |
| `colors`      | `array`     |    ["#2085fc", "#5efca9", "#fd4767"]     | Specify colors of siri wave 9 colors |


## ✨ Credits

- Siri Wave 9 Implementation by: [GreatPotter](https://github.com/GreatPotter)

## 🤔 How to contribute
Have an idea? Found a bug? Please raise to [ISSUES](https://github.com/prscX/PXSiriWave9/issues).
Contributions are welcome and are greatly appreciated! Every little bit helps, and credit will always be given.

## 💫 Where is this library used?
If you are using this library in one of your projects, add it in this list below. ✨


## 📜 License
This library is provided under the Apache License.

PXSiriWave @ [prscX](https://github.com/prscX)

## 💖 Support my projects
I open-source almost everything I can, and I try to reply everyone needing help using these projects. Obviously, this takes time. You can integrate and use these projects in your applications for free! You can even change the source code and redistribute (even resell it).

However, if you get some profit from this or just want to encourage me to continue creating stuff, there are few ways you can do it:
* Starring and sharing the projects you like 🚀
* If you're feeling especially charitable, please follow [prscX](https://github.com/prscX) on GitHub.

  <a href="https://www.buymeacoffee.com/prscX" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>

  Thanks! ❤️
  <br/>
  [prscX.github.io](https://prscx.github.io)
  <br/>
  </ Pranav >