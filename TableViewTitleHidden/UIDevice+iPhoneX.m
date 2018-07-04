//
//  UIDevice+iPhoneX.m
//  TableViewTitleHidden
//
//  Created by 吕召 on 2018/7/4.
//  Copyright © 2018年 铭创信科. All rights reserved.
//

#import "UIDevice+iPhoneX.h"

@implementation UIDevice (iPhoneX)
+ (BOOL)isIphoneX{
    
    if([UIScreen mainScreen].bounds.size.height == 812){
        return YES;
    }
    return NO;
    
}
@end
