//
//  ScrollLabelView.m
//  https://github.com/TakayoshiMiyamoto/ScrollLabelView.git
//
//  Copyright (c) 2015 Takayoshi Miyamoto. All rights reserved.
//

#import "ScrollLabelView.h"

static const NSInteger kDefaultLabelFontSize = 12;

static const CGFloat kDefaultAnimateDuration = 1.f;
static const CGFloat kDefaultAnimateDelay = .5f;

#define kDefaultLabelTextColor ([UIColor blackColor])
#define kDefaultLabelBackgroundColor ([UIColor clearColor])

@interface ScrollLabelView()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *flashTextLabel;

@property (nonatomic, assign) BOOL begining;

@end

@implementation ScrollLabelView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self _initialize];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    [self _initialize];
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.clipsToBounds = YES;
}

#pragma mark - Public methods

- (void)begin:(void (^)(void))finished {
    if (_begining) {
        return;
    }
    _begining = YES;

    CGRect mainBounds = [self bounds];
    
    CGFloat duration = [self animateDuration] > 0 ? [self animateDuration] : kDefaultAnimateDuration;
    CGFloat delay = [self animateDelay] > 0 ? [self animateDelay] : kDefaultAnimateDelay;
    
    [self _refreshLabel];
    
    _textLabel.frame = CGRectMake(0, -CGRectGetHeight(mainBounds),
                                  CGRectGetWidth(mainBounds), CGRectGetHeight(mainBounds));
    _flashTextLabel.frame = CGRectMake(0, 0,
                                       CGRectGetWidth(mainBounds), CGRectGetHeight(mainBounds));

    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        _flashTextLabel.frame = CGRectMake(0, CGRectGetHeight(mainBounds),
                                           CGRectGetWidth(mainBounds), CGRectGetHeight(mainBounds));
    } completion:^(BOOL f) {
        _flashTextLabel.frame = CGRectMake(0, -CGRectGetHeight(mainBounds),
                                           CGRectGetWidth(mainBounds), CGRectGetHeight(mainBounds));
    }];
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        _textLabel.frame = CGRectMake(0, 0, CGRectGetWidth(mainBounds), CGRectGetHeight(mainBounds));
    } completion:^(BOOL f) {
        [NSThread sleepForTimeInterval:delay];
        
        if (finished) {
            finished();
        }
    }];
}

- (void)finish:(void (^)(void))finished {
    if (!_begining) {
        return;
    }
    
    CGRect mainBounds = self.bounds;
    
    CGFloat duration = [self animateDuration] > 0 ? [self animateDuration] : kDefaultAnimateDuration;
    CGFloat delay = [self animateDelay] > 0 ? [self animateDelay] : kDefaultAnimateDelay;
    
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        _textLabel.frame = CGRectMake(0, CGRectGetHeight(mainBounds),
                                      CGRectGetWidth(mainBounds), CGRectGetHeight(mainBounds));
    } completion:nil];
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        _flashTextLabel.frame = CGRectMake(0, 0, CGRectGetWidth(mainBounds), CGRectGetHeight(mainBounds));
    } completion:^(BOOL f) {
        _begining = NO;
        
        if (finished) {
            finished();
        }
    }];
}

- (void)beginAndFinish:(void (^)(void))finished {
    __weak __typeof__(self) weakSelf = self;
    [self begin:^() {
        __typeof__(weakSelf) strongSelf = weakSelf;
        [strongSelf finish:finished];
    }];
}

#pragma mark - Private methods

- (void)_initialize {
    _begining = NO;
    
    CGRect mainBounds = self.bounds;
    
    CGRect textLabelFrame = CGRectMake(0, -CGRectGetHeight(mainBounds),
                                       CGRectGetWidth(mainBounds), CGRectGetHeight(mainBounds));
    
    _textLabel = [[UILabel alloc] initWithFrame:textLabelFrame];
    _textLabel.textAlignment = NSTextAlignmentLeft;
    
    CGRect flashTextLabelFrame = CGRectMake(0, -CGRectGetHeight(mainBounds),
                                            CGRectGetWidth(mainBounds), CGRectGetHeight(mainBounds));
    
    _flashTextLabel = [[UILabel alloc] initWithFrame:flashTextLabelFrame];
    _flashTextLabel.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:_textLabel];
    [self addSubview:_flashTextLabel];
}

- (void)_refreshLabel {
    _textLabel.text = [self flashText];
    _textLabel.textColor = [self flashTextColor] ? [self flashTextColor] : kDefaultLabelTextColor;
    _textLabel.backgroundColor = [self flashTextLabelBackgroundColor] ?
        [self flashTextLabelBackgroundColor] : kDefaultLabelBackgroundColor;
    _textLabel.font = [UIFont systemFontOfSize:[self flashTextFontSize] > 0 ?
                       [self flashTextFontSize] : kDefaultLabelFontSize];

    _flashTextLabel.text = [self text];
    _flashTextLabel.textColor = [self textColor] ? [self textColor] : kDefaultLabelTextColor;
    _flashTextLabel.backgroundColor = [self textLabelBackgroundColor] ?
        [self textLabelBackgroundColor] : kDefaultLabelBackgroundColor;
    _flashTextLabel.font = [UIFont systemFontOfSize:[self textFontSize] > 0 ?
                            [self textFontSize] : kDefaultLabelFontSize];
}

@end
