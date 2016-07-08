//
//  UILabel+NeededFontAndGrayLine.m
//  XiangNanOnHand
//
//  Created by Tony Zhang on 16/6/26.
//  Copyright © 2016年 www.chsh8j.com. All rights reserved.
//

#import "UILabel+NeededFontAndGrayLine.h"
#import "Header.h"

@implementation UILabel (NeededFontAndGrayLine)

-(void)setMyNeededFont{

    if (SCREEN_WIDTH == 320) {
        self.font = [UIFont systemFontOfSize:14];
    }
}

-(void)addGrayLine{

    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = BACK_GRAY.CGColor;
    layer.frame = CGRectMake(0, CGRectGetMinY(self.frame), SCREEN_WIDTH, 2);
    [self.superview.layer addSublayer:layer];
}



@end
