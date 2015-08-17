//
//  ViewController.m
//  StarRatingViewDemo
//
//  Created by fifila on 15/8/17.
//  Copyright (c) 2015年 fifila. All rights reserved.
//

#import "ViewController.h"
#import "StarRatingView.h"
@interface ViewController ()<StarRatingViewDelegate>
@property (strong, nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    StarRatingView *ratingView = [[StarRatingView alloc] initWithFrame:CGRectMake(10, 100, 220, 40) numberOfStars:5];
    ratingView.delegate = self;
    
    [self.view addSubview:ratingView];
    [self.view addSubview:self.label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) starRatingView:(id)sender ratingValueDidChange:(CGFloat)newRatingPercent
{
    int val = newRatingPercent * 100;
    self.label.text= [NSString stringWithFormat:@"%d",val];

}

-(UILabel*) label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(30, 200, 300, 20)];
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
}
@end
