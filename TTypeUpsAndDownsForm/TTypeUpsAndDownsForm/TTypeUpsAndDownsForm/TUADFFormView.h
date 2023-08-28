//
//  TUADFFormView.h
//  TTypeUpsAndDownsForm
//
//  Created by suhongyi on 2023/8/28.
//  Copyright © 2023 alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TUADFFormView ;

@protocol TUADFFormViewDelegate <NSObject>

@optional
/**
 表固定不动列上的自定义View

 @param stockView TUADFFormView
 @return 自定义View
 */
- (UIView*)headFixedView:(TUADFFormView*)stockView;

/**
 左边可滑动头部View

 @param stockView TUADFFormView
 @return 自定义View
 */
- (UIView*)headLeftView:(TUADFFormView*)stockView;

/**
 右边可滑动头部View

 @param stockView TUADFFormView
 @return 自定义View
 */
- (UIView*)headRightView:(TUADFFormView*)stockView;

/**
 头部headView共用这个高度

 @param stockView TUADFFormView
 @return 返回指定高度
 */
- (CGFloat)heightForHeadView:(TUADFFormView*)stockView;

/**
 内容部分高度，左边和右边共用这个高度

 @param stockView TUADFFormView
 @return 返回指定高度
 */
- (CGFloat)heightForCell:(TUADFFormView*)stockView indexPath:(NSIndexPath *)indexPath;

/**
 点击行事件

 @param stockView TUADFFormView
 @param row 当前行的索引值
 */
- (void)didSelect:(TUADFFormView*)stockView rowPath:(NSUInteger)row;

@end

@protocol TUADFFormViewDataSource <NSObject>

@required

/**
 控件内容的总行数

 @param stockView TUADFFormView
 @return 总行数
 */
- (NSUInteger)countForStockView:(TUADFFormView*)stockView;

/**
 FixedView列每一行自定义View

 @param stockView TUADFFormView
 @return 返回自定义View
 */
- (UIView*)cellFixedViewForStockView:(TUADFFormView*)stockView;

/**
 左边内容可滑动自定义View

 @param stockView TUADFFormView
 @return 返回自定义View
 */
- (UIView*)cellLeftContentForStockView:(TUADFFormView*)stockView;


/**
 右边内容可滑动自定义View

 @param stockView TUADFFormView
 @return 返回自定义View
 */
- (UIView*)cellRightContentForStockView:(TUADFFormView*)stockView;



///  更新列表cell的数据
/// @param stockView TUADFFormView
/// @param fixedView  固定列
/// @param leftView 左边滚动视图
/// @param rightView 右边滚动视图
/// @param row 当前行的索引值
- (void)updateCellStockView:(TUADFFormView*)stockView fixedView:(UIView*)fixedView leftContentView:(UIView*)leftView rightContentView:(UIView*)rightView rowPath:(NSUInteger)row;



@end

@interface TUADFFormView : UIView

@property(nonatomic,readwrite,weak)id<TUADFFormViewDataSource> dataSource;


@property(nonatomic,readwrite,weak)id<TUADFFormViewDelegate> delegate;


/**
 具体实现的UITableView,代理由内部实现
 */
@property(nonatomic,readonly,weak)UITableView* tStockTableView;

/**
 刷新控件所有元素
 */
- (void)reloadStockView;

/**
 刷新行的样式

 @param row 指定行的索引值
 */
- (void)reloadStockViewFromRow:(NSUInteger)row;

/**
 滚动到指定行

 @param row 指定行的索引值
 */
- (void)scrollStockViewToRow:(NSUInteger)row;

@end

NS_ASSUME_NONNULL_END
