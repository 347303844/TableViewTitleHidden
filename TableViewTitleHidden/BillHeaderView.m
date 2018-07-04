//
//  BillHeaderView.m
//  TableViewTitleHidden
//
//  Created by 吕召 on 2018/7/4.
//  Copyright © 2018年 铭创信科. All rights reserved.
//

#import "BillHeaderView.h"
#import "Masonry.h"
#import "UIColor+HexColor.h"

@implementation BillHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"0x1E90FF"];
        [self setupView];
    }
    return self;
}


#pragma mark - setupView
- (void)setupView{
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor redColor];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 30;
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(60);
    }];
    self.imageView = imageView;
    
    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"吕召";
    nameLabel.backgroundColor = [UIColor yellowColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).mas_offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(imageView.mas_centerY);
    }];
    self.nameLabel = nameLabel;
    
}

#pragma mark -  get and set




@end
