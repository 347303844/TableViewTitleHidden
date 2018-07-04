//
//  UIColor+HexColor.h
//  TableViewTitleHidden
//
//  Created by 吕召 on 2018/7/4.
//  Copyright © 2018年 铭创信科. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIImage *)switchToImageWithColor:(UIColor *)color size:(CGSize)size;

#pragma mark - 十六进制字符串转换成颜色对象
+ (UIColor *)colorWithHexString:(NSString *)hex;
@end
