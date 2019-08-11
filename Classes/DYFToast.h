//
//  DYFToast.h
//
//  Created by dyf on 16/7/26.
//  Copyright © 2016 dyf.
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

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
