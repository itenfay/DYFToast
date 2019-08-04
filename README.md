# DYFToast

https://github.com/dgynfi/DYFToast.git

`Author: dyf`
`Date: 2017/1/5`

## Usage

## 实例化
```Objective-C
1.DYFToast *toast = [DYFToast makeToast:@"错误的用户名或密码！"];
2.DYFToast *toast = [[DYFToast alloc] initWithText:@"错误的用户名或密码！"];
```

## 位置设置
```Objective-C
typedef enum {
	YTTPlaceAtTopZero, // 屏幕顶端
	YTTPlaceAtTop,	   // 屏幕顶部
	YTTPlaceAtCenter,  // 屏幕中央
	YTTPlaceAtBottom   // 屏幕底部
} YTTPlace;

e.g. toast.place = YTTPlaceAtTopZero;
```

## 时间设置 
```Objective-C
toast.duration = 3.0;
```

## 背景颜色设置
```Objective-C
toast.backgroudColor = [UIColor whiteColor];
```

## 文本颜色设置
```Objective-C
toast.textColor = [UIColor blackColor];
```

## 角弧度设置
```Objective-C
toast.cornerRadius = 10.0;
```

## 边框线宽设置
```Objective-C
toast.borderWidth = 1.5;
```

## 边框线条颜色设置
```Objective-C
toast.borderColor = [UIColor orangeColor];
```

## 注意：
`
当位置为YTTPlaceAtTopZero时，角弧度，边框线条设置无效。
`
