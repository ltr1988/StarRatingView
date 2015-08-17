//
//  StarRatingView.m
//  StarRatingViewDemo
//
//  Created by fifila on 15/8/17.
//  Copyright (c) 2015年 fifila. All rights reserved.
//

#import "StarRatingView.h"

#define FOREGROUND_STAR_IMAGE_NAME @"icon_star_highlight"
#define BACKGROUND_STAR_IMAGE_NAME @"icon_star_gray"
#define DEFAULT_STAR_NUMBER 5
#define ANIMATION_INTERVAL  0.2
@interface StarRatingView ()

@property (nonatomic,strong) UIView *foregroundStarView;
@property (nonatomic,strong) UIView *backgroundStarView;

@property (nonatomic,assign) NSUInteger numberOfStars;
@end

#pragma mark - Init Methods
@implementation StarRatingView
- (instancetype)init {
    NSAssert(NO, @"You should never call this method in this class. Use initWithFrame: instead!");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStars:DEFAULT_STAR_NUMBER];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _numberOfStars = DEFAULT_STAR_NUMBER;
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars {
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        [self setupView];
    }
    return self;
}

#pragma mark - Private Methods

-(void) setupView
{
    _ratingPercent = 1;
    _animated = YES;
    
    [self addSubview:self.backgroundStarView]; 
    [self addSubview:self.foregroundStarView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak StarRatingView *weakSelf = self;
    CGFloat animationTimeInterval = self.animated ? ANIMATION_INTERVAL : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.ratingPercent, weakSelf.bounds.size.height);
    }];
}
#pragma mark - Property Instance

-(UIView*) foregroundStarView
{
    if (!_foregroundStarView) {
        _foregroundStarView = [[UIView alloc] initWithFrame:self.bounds];
        _foregroundStarView.clipsToBounds = YES;
        _foregroundStarView.backgroundColor = [UIColor clearColor];
        
        for (NSUInteger i=0; i<self.numberOfStars; i++) {
            UIImageView *imageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:FOREGROUND_STAR_IMAGE_NAME]];
            imageView.frame= CGRectMake(i*self.bounds.size.width/self.numberOfStars, 0 , self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [_foregroundStarView addSubview:imageView];
        }
    }
    return _foregroundStarView;
}

-(UIView*) backgroundStarView
{
    if (!_backgroundStarView) {
        _backgroundStarView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundStarView.clipsToBounds = YES;
        _backgroundStarView.backgroundColor = [UIColor clearColor];
        
        for (NSUInteger i=0; i<self.numberOfStars; i++) {
            UIImageView *imageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:BACKGROUND_STAR_IMAGE_NAME]];
            imageView.frame= CGRectMake(i*self.bounds.size.width/self.numberOfStars, 0 , self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [_backgroundStarView addSubview:imageView];
        }
    }
    return _backgroundStarView;
}

-(void) setRatingPercent:(CGFloat)ratingPercent
{
    if (_ratingPercent==ratingPercent) {
        return;
    }
    if (ratingPercent<0) {
        _ratingPercent = 0;
    }else
    if (ratingPercent>1) {
        _ratingPercent=1;
    }else
    {
        _ratingPercent=ratingPercent;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRatingView:ratingValueDidChange:)]) {
        [self.delegate starRatingView:self ratingValueDidChange:_ratingPercent];
    }
    
    [self setNeedsLayout];
}

#pragma Touches event
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGFloat offset = [touch locationInView:self].x;
    [self setScoreByOffset:offset];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGFloat offset = [touch locationInView:self].x;
    [self setScoreByOffset:offset];
}

-(void) setScoreByOffset:(CGFloat) offset
{
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    self.ratingPercent = realStarScore / self.numberOfStars;
}
@end

