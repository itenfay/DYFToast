//
//  ViewController.m
//  DYFToast
//
//  Created by Tenfay on 05/13/2024.
//  Copyright (c) 2024 Tenfay. All rights reserved.
//

#import "ViewController.h"
#import "DYFToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)defaultAction:(id)sender {
    Toast().makeText(self.view, "无效的验证码", ToastDuration.LENGTH_SHORT).show();
}

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

- (IBAction)setColorAction:(id)sender {
    UIColor *bgColor   = [UIColor colorWithRed:120/255.0 green:210/255.0 blue:251/255.0 alpha:0.9];
    UIColor *textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    char *message      = "Wrong username and password";
    Toast().makeText(self.view, message, ToastDuration.LENGTH_LONG)
        .setGravity(Gravity.BOTTOM)
        .setColor(bgColor, textColor)
        .show();
}

- (IBAction)setCornerAction:(id)sender {
    char *message = "Please input email";
    Toast().makeText(self.view, message, ToastDuration.LENGTH_LONG)
        .setGravity(Gravity.BOTTOM)
        .setCorner(20)
        .show();
}

- (IBAction)setBorderAction:(id)sender {
    char *message = "手机号码格式不正确，请重输入";
    Toast().makeText(self.view, message, ToastDuration.LENGTH_LONGER)
        .setGravity(Gravity.BOTTOM)
        .setBorder(UIColor.orangeColor, 3)
        .show();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
