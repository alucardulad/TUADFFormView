//
//  TUADFFormTableViewCell.h
//  TTypeUpsAndDownsForm
//
//  Created by suhongyi on 2023/8/28.
//  Copyright © 2023 alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TUADFFormTableViewCell : UITableViewCell
// Cell的左右可滑动的ScrollView,设置成ReadOnly，滚动代理由Table来实现
@property(nonatomic,readonly,strong)UIScrollView* rightContentScrollView;

/// Cell的左右可滑动的ScrollView,设置成ReadOnly，滚动代理由Table来实现
@property(nonatomic,readonly,strong)UIScrollView* leftContentScrollView;

/**
 设置左边的自定义View
 */
@property(nonatomic,readwrite,strong)UIView* fixedView;

/**
 设置右边可以滑动自定义View
 内部实现添加到滚动视图
 */
@property(nonatomic,readwrite,strong)UIView* rightContentView;

/**
设置左边可以滑动自定义View
内部实现添加到滚动视图
*/
@property(nonatomic,readwrite,strong)UIView* leftContentView;
@end

NS_ASSUME_NONNULL_END
