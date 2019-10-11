<div align=center>
<img src="https://github.com/dgynfi/DYFToast/raw/master/images/DYFToast.png" width="90%">
</div>

[如果你觉得能帮助到你，请给一颗小星星。谢谢！(If you think it can help you, please give it a star. Thanks!)](https://github.com/dgynfi/DYFToast)

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/DYFToast.svg?style=flat)](http://cocoapods.org/pods/DYFToast)&nbsp;
![CocoaPods](http://img.shields.io/cocoapods/p/DYFToast.svg?style=flat)&nbsp;

## DYFToast

&emsp; iOS 完全仿Android吐司提示框，采用了链式编程，通过点操作，实现吐司提示框的属性设置和展示，代码简洁，高效。(Fully imitating the Android toast, using chain programming, through point operation, it can achieve the properties settings and display of the toast, the code is concise and efficient.)

## 技术交流群(群号:155353383) 

- 欢迎加入技术交流群，一起探讨技术问题。

<div align=left>
&emsp; <img src="https://github.com/dgynfi/DYFToast/raw/master/images/qq155353383.jpg" width="20%" />
</div>

## 安装

- 支持通过 CocoaPods 安装。

```pod install
pod 'DYFToast', '~> 2.0.2'
```

## 效果图

<div align=left>
&emsp; <img src="https://github.com/dgynfi/DYFToast/raw/master/images/ToastPreview.gif" width="30%" />
</div>

## 使用说明

- 默认设置并显示 (Shows toast with default settings)

```ObjC
- (IBAction)defaultAction:(id)sender {
    Toast().makeText(self.view, "无效的验证码", Toastl.LENGTH_SHORT).show();
}
```

- 设置位置 (Sets gravity)

```ObjC
- (IBAction)setGravityAction:(id)sender {
    static int i = 0;

    GravityType type = Gravity.TOP_EDGE;
    char *message = "网络连接超时，请重试";
    if (i == 0) {
        type = Gravity.TOP_EDGE;
        message = "网络连接超时，请重试";
    } 
    else if (i == 1) {
        type = Gravity.TOP;
        message = "请求失败";
    } 
    else if (i == 2) {
        type = Gravity.CENTER;
        message = "清理完成";
    } 
    else if (i == 3) {
        type = Gravity.BOTTOM;
        message = "请输入用户名";
    }

    i++;
    if (i >= 4) { i = 0; }

    UIView *inView = self.navigationController.view;
    Toast().makeText(inView, message, Toastl.LENGTH_LONG)
    .setGravity(type)
    .show();
}
```

- 设置背景和文本颜色 (Sets background and text color)

```ObjC
- (IBAction)setColorAction:(id)sender {
    UIColor *bgColor   = [UIColor colorWithRed:120/255.0 green:210/255.0 blue:251/255.0 alpha:0.9];
    UIColor *textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    char *message = "Wrong username and password";
    Toast().makeText(self.view, message, Toastl.LENGTH_LONG)
    .setGravity(Gravity.BOTTOM)
    .setColor(bgColor, textColor)
    .show();
}
```

- 设置转角 (Sets corner with radius)

```ObjC
- (IBAction)setCornerAction:(id)sender {
    char *message = "Please input email";
    Toast().makeText(self.view, message, Toastl.LENGTH_LONG)
    .setGravity(Gravity.BOTTOM)
    .setCorner(20)
    .show();
}
```

- 设置边框 (Sets border with the width and color of line)

```ObjC
- (IBAction)setBorderAction:(id)sender {
    char *message = "手机号码格式不正确，请重输入";
    Toast().makeText(self.view, message, Toastl.LENGTH_LONG)
    .setGravity(Gravity.BOTTOM)
    .setBorder(UIColor.orangeColor, 3)
    .show();
}
```

## Sample Codes

- [Sample Codes Gateway](https://github.com/dgynfi/DYFToast/blob/master/Basic%20Files/ViewController.m)
