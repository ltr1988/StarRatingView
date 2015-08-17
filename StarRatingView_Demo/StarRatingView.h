//
//  StarRatingView.h
//  StarRatingViewDemo
//
//  Created by fifila on 15/8/17.
//  Copyright (c) 2015年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>


// value change delegate
@protocol StarRatingViewDelegate <NSObject>

@optional
-(void)starRatingView:(id)sender ratingValueDidChange:(CGFloat)newRatingPercent;
@end

// rating view
@interface StarRatingView : UIView

@property (nonatomic, assign) CGFloat ratingPercent; //ranges from 0 ~ 1.0
@property (nonatomic, assign) BOOL animated;

@property (nonatomic, weak) id<StarRatingViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;
@end
