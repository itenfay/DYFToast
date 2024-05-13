//
//  DYFToast.m
//
//  Created by TengFei on 16/7/26.
//  Copyright © 2016 TengFei.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "DYFToast.h"

// The default background color.
#define BG_COLOR [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9]
// The default text color.
#define TEXT_COLOR [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]

// The window's safe area insets.
#define WSafeAreaInsets UIApplication.sharedApplication.delegate.window.safeAreaInsets

// IPhone X series.
#define IsIPhoneXAll ({BOOL isPhoneXAll = NO; if (@available(iOS 11.0, *)) { isPhoneXAll = WSafeAreaInsets.bottom > 0.0; } isPhoneXAll;})

// The width of srceen.
#define S_W [UIScreen mainScreen].bounds.size.width
// The height of srceen.
#define S_H [UIScreen mainScreen].bounds.size.height

const Gravity_t     Gravity = {1, 2, 3, 4};
const ToastLength_t ToastDuration = {1.5, 2.5, 3.5};

DYFToast *Toast(void) {
    return [DYFToast toast];
}

@interface DYFToast ()

// The view will add the content view.
@property (nonatomic, strong) UIView   *inView;

// The type of gravity, e.g.: Gravity.CENTER.
@property (nonatomic, assign) GravityType gravityType;

// Backgroud color, the  default is transparent black.
@property (nonatomic, strong) UIColor  *backgroudColor;

// Text color, the default is white.
@property (nonatomic, strong) UIColor  *textColor;

// Display time for toast.
@property (nonatomic, assign) double   duration;

// The radius of corner.
@property (nonatomic, assign) CGFloat  cornerRadius;

// The color of border.
@property (nonatomic, strong) UIColor  *borderColor;

// The width of border.
@property (nonatomic, assign) CGFloat  borderWidth;

// Content view for display.
@property (nonatomic, strong) UIButton *contentView;

@end

@implementation DYFToast

+ (instancetype)toast {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.gravityType    = Gravity.CENTER;
        self.duration       = ToastDuration.LENGTH_SHORT;
        self.cornerRadius   = 10.f;
        self.borderWidth    = 0.f;
        
        self.backgroudColor = BG_COLOR;
        self.textColor      = TEXT_COLOR;
        self.borderColor    = UIColor.clearColor;
        
        [self _addRotationObserver];
    }
    return self;
}

- (ToastMakeTextBlock)makeText {
    __weak typeof(self) weakSelf = self;
    ToastMakeTextBlock makeTextBlock = ^DYFToast *(UIView *inView, const char *text, double duration) {
        weakSelf.inView = inView;
        NSString *msg = text ? [NSString stringWithUTF8String:text] : @"";
        [weakSelf configureSubviews:msg];
        if (duration > 0) {
            [weakSelf setDuration:duration];
        }
        return weakSelf;
    };
    return makeTextBlock;
}

- (ToastSetGravityBlock)setGravity {
    __weak typeof(self) weakSelf = self;
    ToastSetGravityBlock block = ^DYFToast *(GravityType type) {
        weakSelf.gravityType = type;
        return weakSelf;
    };
    return block;
}

- (ToastSetColorBlock)setColor {
    __weak typeof(self) weakSelf = self;
    return ^DYFToast *(UIColor *backgroudColor, UIColor *textColor) {
        if (backgroudColor) {
            weakSelf.backgroudColor = backgroudColor;
        }
        if (textColor) {
            weakSelf.textColor = textColor;
        }
        return weakSelf;
    };
}

- (ToastSetCornerBlock)setCorner {
    __weak typeof(self) weakSelf = self;
    return ^DYFToast *(CGFloat radius) {
        if (radius > 0) {
            weakSelf.cornerRadius = radius;
        }
        return weakSelf;
    };
}

- (ToastSetBorderBlock)setBorder {
    __weak typeof(self) weakSelf = self;
    return ^DYFToast *(UIColor *color, CGFloat width) {
        if (color) {
            weakSelf.borderColor = color;
        }
        if (width > 0) {
            weakSelf.borderWidth = width;
        }
        return weakSelf;
    };
}

- (ToastShowBlock)show {
    __weak typeof(self) weakSelf = self;
    return ^(void) {
        [weakSelf _show];
    };
}

- (void)configureSubviews:(NSString *)text {
    self.contentView          = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.contentView addTarget:self
                         action:@selector(toastClicked:)
               forControlEvents:UIControlEventTouchDown];
    
    UILabel *textLabel        = [[UILabel alloc] init];
    textLabel.tag             = 10;
    textLabel.text            = text;
    textLabel.numberOfLines   = 0;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font            = [UIFont boldSystemFontOfSize:15.f];
    textLabel.textAlignment   = NSTextAlignmentCenter;
    textLabel.lineBreakMode   = NSLineBreakByCharWrapping;
    [self.contentView addSubview:textLabel];
}

- (void)toastClicked:(UIButton *)sender {
    [self useAnimationToHide];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(useAnimationToHide) object:nil];
}

- (void)_show {
    UILabel *textLabel = [self.contentView viewWithTag:10];
    if (textLabel.text.length > 0) {
        [self.inView addSubview:self.contentView];
        [self.inView bringSubviewToFront:self.contentView];
        [self updateLayouts];
        [self updateProperties];
        [self useAnimationToShow];
        [self performSelector:@selector(useAnimationToHide)
                   withObject:nil
                   afterDelay:self.duration];
    }
}

- (void)useAnimationToShow {
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.35];
    
    if (self.gravityType != Gravity.TOP_EDGE) {
        self.contentView.alpha = 1.f;
    } else {
        CGRect rect = self.contentView.frame;
        rect.origin.y = (IsIPhoneXAll && [self isPortrait]) ? [self _edgeTop] : 0.f;
        self.contentView.frame = rect;
    }
    
    [UIView commitAnimations];
}

- (void)useAnimationToHide {
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.35];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(_removeToast)];
    
    if (self.gravityType != Gravity.TOP_EDGE) {
        self.contentView.alpha = 0.f;
    } else {
        CGRect rect = self.contentView.frame;
        rect.origin.y = -rect.size.height;
        self.contentView.frame = rect;
    }
    
    [UIView commitAnimations];
}

- (void)_removeToast {
    [self.contentView removeFromSuperview];
}

- (CGFloat)_edgeTop {
    if (@available(iOS 11.0, *)) {
        CGFloat top = WSafeAreaInsets.top;
        return top > 0 ? top : 20.f;
    }
    return 20.f;
}

- (void)updateLayouts {
    BOOL ret                    = ([self isPortrait] || [self iOS8OrLater]);
    CGFloat dW                  = ret ? S_W : S_H;
    UILabel *textLabel          = [self.contentView viewWithTag:10];
    NSDictionary *attrs         = [NSDictionary dictionaryWithObject:textLabel.font forKey:NSFontAttributeName];
    NSStringDrawingOptions opts = (NSStringDrawingTruncatesLastVisibleLine |
                                   NSStringDrawingUsesFontLeading          |
                                   NSStringDrawingUsesLineFragmentOrigin);
    CGRect rect                 = [textLabel.text boundingRectWithSize:CGSizeMake(dW * 0.9, CGFLOAT_MAX) options:opts attributes:attrs context:nil];
    
    if (self.gravityType == Gravity.TOP_EDGE) {
        CGFloat ogY             = (IsIPhoneXAll && [self isPortrait]) ? [self _edgeTop] : 0.f;
        self.contentView.frame  = CGRectMake(0, ogY, dW, rect.size.height + 30);
    } else if (self.gravityType == Gravity.TOP) {
        self.contentView.frame  = CGRectMake(0, 0, rect.size.width + 30, rect.size.height + 30);
        UIView *superview       = self.contentView.superview;
        CGFloat cX              = ret ? superview.center.x : superview.center.y;
        self.contentView.center = CGPointMake(cX, 40 + self.contentView.frame.size.height/2);
    } else if (self.gravityType == Gravity.CENTER) {
        self.contentView.frame  = CGRectMake(0, 0, rect.size.width + 30, rect.size.height + 30);
        UIView *superview       = self.contentView.superview;
        CGFloat cX              = ret ? superview.center.x : superview.center.y;
        CGFloat cY              = ret ? superview.center.y : superview.center.x;
        self.contentView.center = CGPointMake(cX, cY);
    } else if (self.gravityType == Gravity.BOTTOM) {
        self.contentView.frame  = CGRectMake(0, 0, rect.size.width + 30, rect.size.height + 30);
        UIView *superview       = self.contentView.superview;
        CGFloat cX              = ret ? superview.center.x : superview.center.y;
        CGFloat dH              = ret ? S_H : S_W;
        self.contentView.center = CGPointMake(cX, dH - (40 + self.contentView.frame.size.height/2));
    }
    
    CGFloat ogX                 = (self.contentView.frame.size.width  - rect.size.width )/2;
    CGFloat ogY                 = (self.contentView.frame.size.height - rect.size.height)/2;
    if (self.gravityType == Gravity.TOP_EDGE) {
        ogX                     = 15.f;
        textLabel.frame         = CGRectMake(ogX, ogY, dW - ogX * 2, rect.size.height);
    } else {
        textLabel.frame         = CGRectMake(ogX, ogY, rect.size.width, rect.size.height);
    }
}

- (void)updateProperties {
    UILabel *textLabel  = [self.contentView viewWithTag:10];
    textLabel.textColor = self.textColor;
    
    if (self.gravityType != Gravity.TOP_EDGE) {
        self.contentView.alpha = 0.f;
    } else {
        CGRect rect = self.contentView.frame;
        rect.origin.y = -rect.size.height;
        self.contentView.frame = rect;
    }
    
    [self setBackgroundImage];
}

- (void)setBackgroundImage {
    UIImage *mImage = nil;
    
    CGRect mRect = self.contentView.bounds;
    CGSize mSize = mRect.size;
    UIBezierPath *path  = nil;
    if (self.gravityType != Gravity.TOP_EDGE) {
        CGSize radii = CGSizeMake(self.cornerRadius, self.cornerRadius);
        UIRectCorner rc = UIRectCornerAllCorners;
        path = [UIBezierPath bezierPathWithRoundedRect:mRect byRoundingCorners:rc cornerRadii:radii];
    } else {
        path = [UIBezierPath bezierPathWithRect:mRect];
    }
    
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:mSize];
        mImage = [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            UIGraphicsImageRendererContext *ctx = rendererContext;
            
            CGContextSetFillColorWithColor  (ctx.CGContext, self.backgroudColor.CGColor);
            CGContextSetStrokeColorWithColor(ctx.CGContext, self.borderColor.CGColor);
            CGContextSetLineWidth           (ctx.CGContext, self.borderWidth);
            
            [path addClip];
            
            CGContextAddPath (ctx.CGContext, path.CGPath);
            CGContextDrawPath(ctx.CGContext, kCGPathFillStroke);
        }];
    } else {
        UIGraphicsBeginImageContext(mSize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor  (context, self.backgroudColor.CGColor);
        CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
        CGContextSetLineWidth           (context, self.borderWidth);
        
        [path addClip];
        
        CGContextAddPath (context, path.CGPath);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        mImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    [self.contentView setBackgroundImage:mImage forState:UIControlStateNormal];
    [self.contentView setBackgroundImage:mImage forState:UIControlStateHighlighted];
}

- (BOOL)iOS8OrLater {
    return ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending);
}

- (BOOL)isPortrait {
    UIApplication *sharedApp = UIApplication.sharedApplication;
    return UIInterfaceOrientationIsPortrait(sharedApp.statusBarOrientation);
}

- (void)handleRotationNotification {
    [self updateLayouts];
}

- (void)_addRotationObserver {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleRotationNotification) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)_removeRotationObserver {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)dealloc {
    [self _removeRotationObserver];
#if DEBUG
    NSLog(@"%s", __func__);
#endif
}

@end
