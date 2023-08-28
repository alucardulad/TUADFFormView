//
//  TUADFFormTableViewCell.m
//  TTypeUpsAndDownsForm
//
//  Created by suhongyi on 2023/8/28.
//  Copyright © 2023 alucardulad. All rights reserved.
//

#import "TUADFFormTableViewCell.h"
#import "TUADFFormScrollView.h"

extern NSInteger kStockHeaderType;

@interface TUADFFormTableViewCell()<UIScrollViewDelegate>{
    @private
    TUADFFormScrollView* _rightContentScrollView;
    TUADFFormScrollView* _leftContentScrollView;
}
@end

@implementation TUADFFormTableViewCell

#pragma mark - Init

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupDefaultSettings];
        [self setupView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"UpdateStockContentViewFrame" object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleNotification: (NSNotification *)nf{
    [self.leftContentScrollView setNeedsLayout];
    [self.rightContentScrollView setNeedsLayout];
}

#pragma mark - Layout

- (void)prepareForReuse{
    [super prepareForReuse];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    
    CGFloat fixedX = self.fixedView.frame.origin.x;
    CGFloat lSideW = CGRectGetWidth(self.frame) / 2.0 - CGRectGetWidth(self.fixedView.frame) / 2.0;
    CGFloat rSideW = CGRectGetWidth(self.frame) / 2.0 - CGRectGetWidth(self.fixedView.frame) / 2.0;
    CGFloat offsetX = CGRectGetWidth(self.leftContentView.frame)-fixedX;
    
    if (kStockHeaderType == 0){
        _rightContentView.hidden = NO;
        _leftContentView.hidden = NO;
        fixedX = CGRectGetWidth(self.frame) / 2.0 - CGRectGetWidth(self.fixedView.frame) / 2.0;
        offsetX = CGRectGetWidth(self.leftContentView.frame)-fixedX;
    } else if (kStockHeaderType == 1){
        rSideW = 0;
        lSideW = CGRectGetWidth(self.frame) - CGRectGetWidth(self.fixedView.frame);
        _rightContentView.hidden = YES;
        _leftContentView.hidden = NO;
        fixedX = CGRectGetWidth(self.frame) - CGRectGetWidth(self.fixedView.frame);
        offsetX = self.leftContentScrollView.contentSize.width - CGRectGetWidth(self.frame);
    } else if (kStockHeaderType == 2){
        lSideW = 0;
        rSideW = CGRectGetWidth(self.frame) - CGRectGetWidth(self.fixedView.frame);
        _leftContentView.hidden = YES;
        _rightContentView.hidden = NO;
        fixedX = 0;
        offsetX = self.leftContentScrollView.contentSize.width - CGRectGetWidth(self.frame);
    }
    
    id tempDelegate = _rightContentScrollView.delegate;
    id templeftDelegate = _rightContentScrollView.delegate;
    _rightContentScrollView.delegate = nil;//Do not send delegate message

    CGRect fixedViewFrame = self.fixedView.frame;
    fixedViewFrame.origin.x = fixedX;
    self.fixedView.frame = fixedViewFrame;
    _rightContentScrollView.frame = CGRectMake(CGRectGetWidth(self.fixedView.frame)+fixedX, 0, rSideW, CGRectGetHeight(self.frame));
    _rightContentScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.rightContentView.frame), CGRectGetHeight(self.frame));
    
    
    _leftContentScrollView.frame = CGRectMake(0, 0, lSideW, CGRectGetHeight(self.frame));
    _leftContentScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.leftContentView.frame), CGRectGetHeight(self.frame));
     _leftContentScrollView.delegate = nil;//Do not send delegate message
    
    [_leftContentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    
    _rightContentScrollView.delegate = tempDelegate;//Restore deleagte
    _leftContentScrollView.delegate = templeftDelegate;//Restore deleagte
}

#pragma mark - Setup

- (void)setupDefaultSettings{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setupView{
    [self.contentView addSubview:self.rightContentScrollView];
    [self.contentView addSubview:self.leftContentScrollView];
}

#pragma mark - Public

- (UIScrollView*)rightContentScrollView{
    if (_rightContentScrollView != nil) {
        return _rightContentScrollView;
    }
    _rightContentScrollView = [TUADFFormScrollView new];
    _rightContentScrollView.clipsToBounds = YES;
    _rightContentScrollView.viewType= TUADFFormScrollViewRight;
    _rightContentScrollView.canCancelContentTouches = YES;
    _rightContentScrollView.showsVerticalScrollIndicator = NO;
    _rightContentScrollView.showsHorizontalScrollIndicator = NO;
    return _rightContentScrollView;
}


- (UIScrollView*)leftContentScrollView{
    if (_leftContentScrollView != nil) {
        return _leftContentScrollView;
    }
    _leftContentScrollView = [TUADFFormScrollView new];
    _leftContentScrollView.clipsToBounds = YES;
    _leftContentScrollView.viewType = TUADFFormScrollViewLeft;
    _leftContentScrollView.canCancelContentTouches = YES;
    _leftContentScrollView.showsVerticalScrollIndicator = NO;
    _leftContentScrollView.showsHorizontalScrollIndicator = NO;
    return _leftContentScrollView;
}

- (void)setFixedView:(UIView *)fixedView{
    if(_fixedView){
          [_fixedView removeFromSuperview];
      }
      [self.contentView addSubview:fixedView];
      _fixedView = fixedView;
      [self setNeedsLayout];
}

- (void)setRightContentView:(UIView*)contentView{
    if(_rightContentView){
        [_rightContentView removeFromSuperview];
    }
    [_rightContentScrollView addSubview:contentView];
    
    _rightContentView = contentView;
    
    [self setNeedsLayout];
}

- (void)setLeftContentView:(UIView*)contentView{
    if(_leftContentView){
        [_leftContentView removeFromSuperview];
    }
    [_leftContentScrollView addSubview:contentView];
    
    _leftContentView = contentView;
    
    [self setNeedsLayout];
}


@end
