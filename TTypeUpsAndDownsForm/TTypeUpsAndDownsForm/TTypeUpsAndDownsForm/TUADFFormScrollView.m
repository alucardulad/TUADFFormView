//
//  TUADFFormScrollView.m
//  TTypeUpsAndDownsForm
//
//  Created by suhongyi on 2023/8/28.
//  Copyright © 2023 alucardulad. All rights reserved.
//

#import "TUADFFormScrollView.h"

@implementation TUADFFormScrollView

/**
 重写touchesShouldCancelInContentView  Button作为子View时，也能正常滑动
 @param view UIView
 @return 如果返回YES 正常滑动
 */
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ( [view isKindOfClass:[UIButton class]] ) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
