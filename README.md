<div align=center>
<img src="https://github.com/itenfay/DYFToast/raw/master/images/DYFToast.png" width="50%">
</div>

**中文版** | [English Version](README-en.md)

## DYFToast

采用链式编程和点语法操作，实现 iOS 仿真安卓吐司提示框。

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/DYFToast.svg?style=flat)](http://cocoapods.org/pods/DYFToast)&nbsp;
![CocoaPods](http://img.shields.io/cocoapods/p/DYFToast.svg?style=flat)&nbsp;

## QQ群 (ID:614799921)

<div align=left>
&emsp; <img src="https://github.com/itenfay/DYFToast/raw/master/images/g614799921.jpg" width="30%" />
</div>

## 安装

使用 [CocoaPods](https://cocoapods.org):

```
pod 'DYFToast'
```

Or

```
pod 'DYFToast', '~> 2.1.0'
```

## 预览

<div align=left>
&emsp; <img src="https://github.com/itenfay/DYFToast/raw/master/images/ToastPreview.gif" width="30%" />
</div>

> 如果能帮助到你，就请你给一颗`star`。谢谢！

## 使用

- 默认设置并显示

```
- (IBAction)defaultAction:(id)sender {
    Toast().makeText(self.view, "无效的验证码", ToastDuration.LENGTH_SHORT).show();
}
```

- 设置位置

```
- (IBAction)setGravityAction:(id)sender {
    static int i = 0;

    GravityType type = Gravity.TOP_EDGE;
    char *message = "网络连接超时，请重试";
    if (i == 0) {
        type = Gravity.TOP_EDGE;
        message = "网络连接超时，请重试";
    } else if (i == 1) {
        type = Gravity.TOP;
        message = "请求失败";
    } else if (i == 2) {
        type = Gravity.CENTER;
        message = "清理完成";
    } else if (i == 3) {
        type = Gravity.BOTTOM;
        message = "请输入用户名";
    }

    i++;
    if (i >= 4) { i = 0; }

    UIView *inView = self.navigationController.view;
    Toast().makeText(inView, message, ToastDuration.LENGTH_LONG)
    .setGravity(type)
    .show();
}
```

- 设置背景和文本颜色

```
- (IBAction)setColorAction:(id)sender {
    UIColor *bgColor   = [UIColor colorWithRed:120/255.0 green:210/255.0 blue:251/255.0 alpha:0.9];
    UIColor *textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    char *message = "Wrong username and password";
    Toast().makeText(self.view, message, ToastDuration.LENGTH_LONG)
    .setGravity(Gravity.BOTTOM)
    .setColor(bgColor, textColor)
    .show();
}
```

- 设置转角

```
- (IBAction)setCornerAction:(id)sender {
    char *message = "Please input email";
    Toast().makeText(self.view, message, ToastDuration.LENGTH_LONG)
    .setGravity(Gravity.BOTTOM)
    .setCorner(20)
    .show();
}
```

- 设置边框

```
- (IBAction)setBorderAction:(id)sender {
    char *message = "手机号码格式不正确，请重输入";
    Toast().makeText(self.view, message, ToastDuration.LENGTH_LONGER)
    .setGravity(Gravity.BOTTOM)
    .setBorder(UIColor.orangeColor, 3)
    .show();
}
```
