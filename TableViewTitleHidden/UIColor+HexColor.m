//
//  UIColor+HexColor.m
//  TableViewTitleHidden
//
//  Created by 吕召 on 2018/7/4.
//  Copyright © 2018年 铭创信科. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)


/**
 
 * 创建纯色的图片，用来做背景
 
 */

+ (UIImage *)switchToImageWithColor:(UIColor *)color size:(CGSize)size

{
    
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    
    [color set];
    
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    UIImage *ColorImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return ColorImg;
    
}
#pragma mark - 十六进制字符串转换成颜色对象
+ (UIColor *)colorWithHexString:(NSString *)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
