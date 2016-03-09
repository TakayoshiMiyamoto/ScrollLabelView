//
//  ScrollLabelView.h
//  https://github.com/TakayoshiMiyamoto/ScrollLabelView.git
//
//  Copyright (c) 2015 Takayoshi Miyamoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollLabelView : UIView

// Text
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *flashText;

// Color
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *textLabelBackgroundColor;
@property (nonatomic, strong) UIColor *flashTextColor;
@property (nonatomic, strong) UIColor *flashTextLabelBackgroundColor;

@property (nonatomic, assign) NSInteger textFontSize;
@property (nonatomic, assign) NSInteger flashTextFontSize;

@property (nonatomic, assign) CGFloat animateDuration;
@property (nonatomic, assign) CGFloat animateDelay;

- (void)begin:(void (^)(void))finished;
- (void)finish:(void (^)(void))finished;
- (void)beginAndFinish:(void (^)(void))finished;

@end
