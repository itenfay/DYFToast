<div align=center>
<img src="https://github.com/dgynfi/DYFToast/raw/master/images/DYFToast.png" width="90%">
</div>

[如果你觉得能帮助到你，请给一颗小星星。谢谢！(If you think it can help you, please give it a star. Thanks!)](https://github.com/dgynfi/DYFToast)

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/DYFToast.svg?style=flat)](http://cocoapods.org/pods/DYFToast)&nbsp;
![CocoaPods](http://img.shields.io/cocoapods/p/DYFToast.svg?style=flat)&nbsp;
[![Build Status](https://travis-ci.org/dgynfi/DYFToast.svg?branch=master)](https://travis-ci.org/dgynfi/DYFToast)

## DYFToast

iOS 完全仿Android吐司提示框，采用了链式编程，通过点操作，实现吐司提示框的属性设置和展示，代码简洁，高效。(Fully imitating the Android toast, using chain programming, through point operation, it can achieve the properties settings and display of the toast, the code is concise and efficient.)

## 技术交流群(群号:155353383) 

欢迎加入技术交流群，一起探讨技术问题。<br />
![](https://github.com/dgynfi/DYFToast/raw/master/images/qq155353383.jpg)

## 安装

- 支持通过 CocoaPods 安装。
```pod install
pod 'DYFToast', '~> 2.0.1'
```

## 效果图

<div align=left>
<img src="https://github.com/dgynfi/DYFToast/raw/master/images/ToastPreview.gif" width="40%" />
</div>

## 使用说明

- 默认设置并显示(Shows toast with default settings)

```ObjC
- (IBAction)defaultAction:(id)sender {
    Toast().makeText(self.view, "无效的验证码", Toastl.LENGTH_SHORT).show();
}
```

- 设置位置(Sets gravity)

```ObjC
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
    Toast().makeText(inView, message, Toastl.LENGTH_LONG)
    .setGravity(type)
    .show();
}
```

- 设置背景和文本颜色(Sets background and text color)

```ObjC
- (IBAction)setColorAction:(id)sender {
    UIColor *bgColor   = [UIColor colorWithRed:120/255.0 green:210/255.0 blue:251/255.0 alpha:0.9];
    UIColor *textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    char *message      = "Wrong username and password";
    Toast().makeText(self.view, message, Toastl.LENGTH_LONG)
    .setGravity(Gravity.BOTTOM)
    .setColor(bgColor, textColor)
    .show();
}
```

- 设置转角(Sets corner with radius)

```ObjC
- (IBAction)setCornerAction:(id)sender {
    char *message = "Please input email";
    Toast().makeText(self.view, message, Toastl.LENGTH_LONG)
    .setGravity(Gravity.BOTTOM)
    .setCorner(20)
    .show();
}
```

- 设置边框(Sets border with the width and color of line)

```ObjC
- (IBAction)setBorderAction:(id)sender {
    char *message = "手机号码格式不正确，请重输入";
    Toast().makeText(self.view, message, Toastl.LENGTH_LONG)
    .setGravity(Gravity.BOTTOM)
    .setBorder(UIColor.orangeColor, 3)
    .show();
}
```

## Codes and Comments

``` ObjC
@class DYFToast;

// Renames unsigned int as GravityType
typedef unsigned int GravityType;

// Declares a `Gravity_t` struct.
struct Gravity_t {
    GravityType TOP_EDGE; // At the top edge of the screen.
    GravityType TOP;      // At the top of the screen.
    GravityType CENTER;   // At the center of the screen.
    GravityType BOTTOM;   // At the bottom of the screen.
};
typedef struct Gravity_t Gravity_t;

// A constant structure(`Gravity`) is declared.
CG_EXTERN const Gravity_t Gravity;

// Declares a `ToastLength_t` struct.
struct ToastLength_t {
    double LENGTH_SHORT;
    double LENGTH_LONG;
};
typedef struct ToastLength_t ToastLength_t;

// A constant structure(`Toastl`) is declared.
CG_EXTERN const ToastLength_t Toastl;

/** Declares a making text block that contains the super view, text and duration. */
typedef DYFToast *(^ToastMakeTextBlock)(UIView *inView, const char *text, double duration);

/** Declares a gravity setter block that contains the gravity type. */
typedef DYFToast *(^ToastSetGravityBlock)(GravityType type);

/** Declares a color setter block that contains the backgroud and text color. */
typedef DYFToast *(^ToastSetColorBlock)(UIColor *backgroudColor, UIColor *textColor);

/** Declares all corners setter block that contains the radius. */
typedef DYFToast *(^ToastSetCornerBlock)(CGFloat radius);

/** Declares a border setter block that contains the color and width. */
typedef DYFToast *(^ToastSetBorderBlock)(UIColor *color, CGFloat width);

/** Declares a toast show block. */
typedef void (^ToastShowBlock)(void);

/** Returns an `DYFToast` instance. */
CG_EXTERN DYFToast *Toast();

@interface DYFToast : NSObject

/** Returns an `DYFToast` instance with the class method. */
+ (instancetype)toast;

/** Sets up the super view, text and display time by calling the `ToastMakeTextBlock` block. */
- (ToastMakeTextBlock)makeText;

/** Sets up the gravity by calling the `ToastSetGravityBlock` block. */
- (ToastSetGravityBlock)setGravity;

/** Sets up the background and text color by calling the `ToastSetColorBlock` block. */
- (ToastSetColorBlock)setColor;

/** Sets up the corners that contains the radius by calling the `ToastSetCornerBlock` block. */
- (ToastSetCornerBlock)setCorner;

/** Sets up the border that contains the color and width by calling the `ToastSetBorderBlock` block. */
- (ToastSetBorderBlock)setBorder;

/** Shows toast by calling the `ToastShowBlock` block. */
- (ToastShowBlock)show;

@end
```
