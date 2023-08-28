//
//  TUADFFormView.m
//  TTypeUpsAndDownsForm
//
//  Created by suhongyi on 2023/8/28.
//  Copyright © 2023 alucardulad. All rights reserved.
//

#import "TUADFFormView.h"
#import "TUADFFormScrollView.h"
#import "TUADFFormTableViewCell.h"

static NSString* const CellID = @"cellID";
extern NSInteger kStockHeaderType;

@interface TUADFFormView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    
    //左边最后一次滑动x坐标，滚动列表视图使用
    CGFloat _lastRightScrollX;
    
    //右边最后一次滑动x坐标，滚动列表视图使用
    CGFloat _lastLeftScrollX;
    
}


/// 整体列表
@property(nonatomic,readwrite,strong) UITableView* stockTableView;

/// 右边头部
@property(nonatomic,readwrite,strong) TUADFFormScrollView* rightHeadScrollView;

/// 左边列表
@property(nonatomic,readwrite,strong) TUADFFormScrollView* leftHeadScrollView;

@end

@implementation TUADFFormView

#pragma mark - Init/Override

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setupView];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    self.stockTableView.backgroundColor = backgroundColor;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _stockTableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

#pragma mark - Setup

- (void)setupView{
    [self addSubview:self.stockTableView];
}

#pragma mark - Public

- (void)reloadStockView{
    [self.stockTableView reloadData];
    [self.stockTableView layoutIfNeeded];
    [self scrollToLastScrollX];
}

- (void)reloadStockViewFromRow:(NSUInteger)row{
    [self.stockTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self scrollToLastScrollX];
}

- (void)scrollStockViewToRow:(NSUInteger)row{
    [self.stockTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (UITableView*)tStockTableView{
    return _stockTableView;
}

#pragma mark - TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSParameterAssert(self.dataSource);
    
    TUADFFormTableViewCell* cell = (TUADFFormTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        
        cell = [[TUADFFormTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.rightContentScrollView.delegate = self;
        cell.leftContentScrollView.delegate = self;
    }
    
    if([self.dataSource respondsToSelector:@selector(cellLeftContentForStockView:)]){
        [cell setLeftContentView:[self.dataSource cellLeftContentForStockView:self]];
    }
    
    if([self.dataSource respondsToSelector:@selector(cellFixedViewForStockView:)]){
        [cell setFixedView:[self.dataSource cellFixedViewForStockView:self]];
    }
    
    if([self.dataSource respondsToSelector:@selector(cellRightContentForStockView:)]){
        [cell setRightContentView:[self.dataSource cellRightContentForStockView:self]];
    }
    
    if([self.dataSource respondsToSelector:@selector(updateCellStockView: fixedView: leftContentView: rightContentView:rowPath:)]){
        [self.dataSource updateCellStockView:self fixedView:cell.fixedView leftContentView:cell.leftContentView rightContentView:cell.rightContentView rowPath:indexPath.row];
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(heightForCell:indexPath:)]){
        return [self.delegate heightForCell:self indexPath:indexPath];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSParameterAssert(self.dataSource);
    if([self.dataSource respondsToSelector:@selector(countForStockView:)]){
        return [self.dataSource countForStockView:self];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([self.delegate respondsToSelector:@selector(heightForHeadView:)]){
        return [self.delegate heightForHeadView:self];
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    CGFloat fixediewWidth = 0.0f;
    CGFloat fixediewx = 0.0f;
    CGFloat headHeight = 0.0f;
    
    if([self.delegate respondsToSelector:@selector(headFixedView:)]){
        UIView* fixediew = [self.delegate headFixedView:self];
        [headerView addSubview:fixediew];
        fixediewWidth = CGRectGetWidth(fixediew.frame);
        fixediewx = CGRectGetMinX(fixediew.frame);
    }
    
    if([self.delegate respondsToSelector:@selector(heightForHeadView:)]){
        headHeight =  [self.delegate heightForHeadView:self];
    }
    
    [headerView addSubview:self.rightHeadScrollView];
    [headerView addSubview:self.leftHeadScrollView];
    

    CGFloat lSideW = CGRectGetWidth(self.frame) / 2.0 - fixediewWidth / 2.0;
    CGFloat rSideW = CGRectGetWidth(self.frame) / 2.0 - fixediewWidth / 2.0;
    
    if (kStockHeaderType == 0){
        self.rightHeadScrollView.hidden = NO;
        self.leftHeadScrollView.hidden = NO;
        fixediewx = CGRectGetWidth(self.frame) / 2.0 - fixediewWidth / 2.0;
    } else if (kStockHeaderType == 1){
        rSideW = 0;
        lSideW = CGRectGetWidth(self.frame) - fixediewWidth;
        self.rightHeadScrollView.hidden = YES;
        fixediewx = CGRectGetWidth(self.frame) - fixediewWidth;
    } else if (kStockHeaderType == 2){
        lSideW = 0;
        rSideW = CGRectGetWidth(self.frame) - fixediewWidth;
        self.leftHeadScrollView.hidden = YES;
        fixediewx = 0;
    }
    
    self.rightHeadScrollView.frame = CGRectMake(fixediewx+fixediewWidth,0, rSideW,headHeight);
    self.leftHeadScrollView.frame = CGRectMake(0,0,lSideW,headHeight);
    
    if([self.delegate respondsToSelector:@selector(headLeftView:)] && [self.delegate respondsToSelector:@selector(headRightView:)] ){
        UIView* rightView = [self.delegate headRightView:self];
        [self.rightHeadScrollView addSubview:rightView];
        
        UIView* leftView = [self.delegate headLeftView:self];
        [self.leftHeadScrollView addSubview:leftView];
        
        self.rightHeadScrollView.contentSize = CGSizeMake(CGRectGetWidth(rightView.frame), headHeight);
        self.leftHeadScrollView.contentSize = CGSizeMake(CGRectGetWidth(leftView.frame), headHeight);
        
        CGFloat leftOffsetX = CGRectGetWidth(leftView.frame)- fixediewWidth;
        if (kStockHeaderType == 0){
//            leftOffsetX = self.leftHeadScrollView.contentSize.width;
        } else if (kStockHeaderType == 1){
            leftOffsetX = self.leftHeadScrollView.contentSize.width - CGRectGetWidth(self.frame) + fixediewWidth;
        } else if (kStockHeaderType == 2){
            leftOffsetX = self.leftHeadScrollView.contentSize.width;
        }
                                                            
                                                              
        
        [self.leftHeadScrollView setContentOffset:CGPointMake(leftOffsetX, 0) animated:NO];
    }
    
    return headerView;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.stockTableView){
        [self scrollToLastScrollX];
    }else if(scrollView == self.rightHeadScrollView || scrollView == self.leftHeadScrollView){
        [self linkAgeScrollView:scrollView];
    }else{
        [self linkAgeScrollView:scrollView];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.stockTableView){
        [self scrollToLastScrollX];
    }else if(scrollView == self.rightHeadScrollView || scrollView == self.leftHeadScrollView){
        [self linkAgeScrollView:scrollView];
    }else{
        [self linkAgeScrollView:scrollView];
    }
}

#pragma mark - Control Scroll

- (void)linkAgeScrollView:(UIScrollView*)sender{
    NSArray* visibleCells = [self.stockTableView visibleCells];
    TUADFFormScrollView * scrollView = (TUADFFormScrollView *)sender;
    CGFloat  scrollViewCW = scrollView.contentSize.width;
    CGFloat  scrollViewFW = scrollView.frame.size.width;
    for (TUADFFormTableViewCell* cell in visibleCells) {
        if (cell.rightContentScrollView != sender) {
            CGFloat scrollX = sender.contentOffset.x;
            if(scrollView.viewType == TUADFFormScrollViewLeft){ //滑动得组件为左边时，右边滑动取反向
                scrollX = scrollViewCW-scrollViewFW-sender.contentOffset.x;
            }
            [self updateScrollView:cell.rightContentScrollView toLastScrollX:scrollX];
        }
        if (cell.leftContentScrollView != sender) {
            CGFloat scrollX = sender.contentOffset.x;
            if(scrollView.viewType == TUADFFormScrollViewRight){ //滑动得组件为右边时，左边滑动取反向
                scrollX = scrollViewCW-scrollViewFW-sender.contentOffset.x ;
            }
            [self updateScrollView:cell.leftContentScrollView toLastScrollX:scrollX];
        }
    }
    //内容滑动视图需要更新头部
    if (sender != self.rightHeadScrollView) {
        CGFloat scrollX = sender.contentOffset.x;
        if(scrollView.viewType == TUADFFormScrollViewLeft){
            scrollX = scrollViewCW-scrollViewFW-sender.contentOffset.x ;
        }
        [self updateScrollView:self.rightHeadScrollView toLastScrollX:scrollX];
    }
    
    if (sender != self.leftHeadScrollView) {
        CGFloat scrollX = sender.contentOffset.x;
        if(scrollView.viewType == TUADFFormScrollViewRight){
            scrollX = scrollViewCW-scrollViewFW-sender.contentOffset.x ;
        }
        [self updateScrollView:self.leftHeadScrollView toLastScrollX:scrollX];
    }
    //stockTableView 需要两个值进行重绘更多cell偏移
    _lastRightScrollX = self.rightHeadScrollView.contentOffset.x;
    _lastLeftScrollX = self.leftHeadScrollView.contentOffset.x;
}

- (void)scrollToLastScrollX{
    NSArray* visibleCells = [self.stockTableView visibleCells];
    for (TUADFFormTableViewCell* cell in visibleCells) {
        [self updateScrollView:cell.rightContentScrollView toLastScrollX:_lastRightScrollX];
        [self updateScrollView:cell.leftContentScrollView toLastScrollX:_lastLeftScrollX];
    }
    [self updateScrollView:self.rightHeadScrollView toLastScrollX:_lastRightScrollX];
    [self updateScrollView:self.leftHeadScrollView toLastScrollX:_lastLeftScrollX];
}

- (void)updateScrollView:(UIScrollView*)scrollView toLastScrollX:(CGFloat)scrollX{
    //先取消代理避免多次调用，后续在重新注册代理
    scrollView.delegate = nil;
    [scrollView setContentOffset:CGPointMake(scrollX, 0) animated:NO];
    scrollView.delegate = self;
}
#pragma mark - Property Get

- (UITableView*)stockTableView{
    if(_stockTableView != nil){
        return _stockTableView;
    }
    _stockTableView = [UITableView new];
    _stockTableView.dataSource = self;
    _stockTableView.delegate = self;
    _stockTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _stockTableView;
}

- (TUADFFormScrollView*)rightHeadScrollView{
    if(_rightHeadScrollView != nil){
        return _rightHeadScrollView;
    }
    _rightHeadScrollView = [TUADFFormScrollView new];
    _rightHeadScrollView.clipsToBounds = YES;
    _rightHeadScrollView.backgroundColor = [UIColor whiteColor];
    _rightHeadScrollView.showsVerticalScrollIndicator = NO;
    _rightHeadScrollView.viewType = TUADFFormScrollViewRight;
    _rightHeadScrollView.showsHorizontalScrollIndicator = NO;
    _rightHeadScrollView.delegate = self;
    return _rightHeadScrollView;
}

- (TUADFFormScrollView*)leftHeadScrollView{
    if(_leftHeadScrollView != nil){
        return _leftHeadScrollView;
    }
    _leftHeadScrollView = [TUADFFormScrollView new];
    _leftHeadScrollView.clipsToBounds = YES;
    _leftHeadScrollView.backgroundColor = [UIColor whiteColor];
    _leftHeadScrollView.viewType = TUADFFormScrollViewLeft;
    _leftHeadScrollView.showsVerticalScrollIndicator = NO;
    _leftHeadScrollView.showsHorizontalScrollIndicator = NO;
    _leftHeadScrollView.delegate = self;
    return _leftHeadScrollView;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
