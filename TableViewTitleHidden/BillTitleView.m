//
//  BillTitleView.m
//  TableViewTitleHidden
//
//  Created by 吕召 on 2018/7/4.
//  Copyright © 2018年 铭创信科. All rights reserved.
//

#import "BillTitleView.h"
#import "Masonry.h"
#import "UIColor+HexColor.h"

@implementation BillTitleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithHexString:@"0x1E9099"];
        [self setupView];
    }
    return self;
}

#pragma mark - setupView
- (void)setupView{
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor redColor];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 15;
    [self addSubview:imageView];
    imageView.hidden = YES;
    imageView.frame = CGRectMake(10, 7, 30, 30);
    
    self.imageView = imageView;

    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"吕召";
    nameLabel.backgroundColor = [UIColor yellowColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:nameLabel];
    nameLabel.frame = CGRectMake((self.frame.size.width - 50 )/2.0, (self.frame.size.height- 15)/2, 50, 15);
    self.nameLabel = nameLabel;

}



@end
