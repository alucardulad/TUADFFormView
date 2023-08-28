//
//  ViewController.m
//  TTypeUpsAndDownsForm
//
//  Created by suhongyi on 2023/8/28.
//

#import "ViewController.h"
#import "TUADFFormView.h"

NSInteger kStockHeaderType = 0;
@interface ViewController ()<TUADFFormViewDelegate,TUADFFormViewDataSource>
@property(nonatomic,readwrite,strong)TUADFFormView* stockView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *lSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lSideButton setTitle:@"期权看涨" forState:UIControlStateNormal];
    [lSideButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    lSideButton.frame = CGRectMake(0, 100, 100, 50);
    [lSideButton addTarget:self action:@selector(displayMoreLeftSide:) forControlEvents:UIControlEventTouchUpInside];
    [lSideButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:lSideButton];
    
    UIButton *rSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rSideButton setTitle:@"期权看跌" forState:UIControlStateNormal];
    [rSideButton setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
    rSideButton.frame = CGRectMake(CGRectGetWidth(self.view.bounds)-100, 100, 100, 50);
    [rSideButton addTarget:self action:@selector(displayMoreRightSide:) forControlEvents:UIControlEventTouchUpInside];
    [rSideButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:rSideButton];
    
    self.stockView.frame = CGRectMake(0, 150, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-150);
    [self.view addSubview:self.stockView];
}

- (void)displayMoreLeftSide: (id)sender{
    kStockHeaderType = kStockHeaderType == 1 ? 0 : 1;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateStockContentViewFrame" object:nil userInfo:@{@"type": @1}];
    [self.stockView reloadStockView];
}

- (void)displayMoreRightSide: (id)sender{
    kStockHeaderType = kStockHeaderType == 2 ? 0 : 2;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateStockContentViewFrame" object:nil userInfo:@{@"type": @2}];
    [self.stockView reloadStockView];
}

#pragma mark - Stock DataSource


- (NSUInteger)countForStockView:(TUADFFormView*)stockView{
     return 30;
}

- (UIView*)cellFixedViewForStockView:(TUADFFormView*)stockView {
    CGFloat x = CGRectGetMidX(self.view.bounds) - 50;
    if (kStockHeaderType == 1){
        x = CGRectGetMaxX(self.view.frame) - 100;
    } else if (kStockHeaderType == 2){
        x = 0;
    }
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, 100, 30)];
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
    
}


- (UIView*)cellLeftContentForStockView:(TUADFFormView*)stockView {
         UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 30)];
        for (int i = 9; i >= 0; i--) {
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake((9-i) * 100, 0, 100, 30)];
            label.textAlignment = NSTextAlignmentCenter;
            [bg addSubview:label];
        }
        return bg;
}


- (UIView*)cellRightContentForStockView:(TUADFFormView*)stockView{
        UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 30)];
        for (int i = 0; i < 10; i++) {
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
            label.textAlignment = NSTextAlignmentCenter;
            [bg addSubview:label];
        }
        return bg;
}


#pragma mark -  Delegate

- (UIView*)headFixedView:(TUADFFormView*)stockView{
    CGFloat x = CGRectGetMidX(self.view.bounds) - 50;
    if (kStockHeaderType == 1){
        x = CGRectGetMaxX(self.view.frame) - 100;
    } else if (kStockHeaderType == 2){
        x = 0;
    }
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, 100, 40)];
     label.text = @"顶部栏目";
     label.backgroundColor = [UIColor whiteColor];
     label.textColor = [UIColor grayColor];
     label.textAlignment = NSTextAlignmentCenter;
     return label;
}

- (UIView*)headLeftView:(TUADFFormView*)stockView{
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 40)];
    for (int i = 9; i >= 0; i--) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake((9-i) * 100, 0, 100, 40)];
        label.text = [NSString stringWithFormat:@"左顶部:%d",i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        [bg addSubview:label];
    }
    return bg;
}

- (UIView*)headRightView:(TUADFFormView*)stockView{
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 40)];
    for (int i = 0; i < 10; i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 40)];
        label.text = [NSString stringWithFormat:@"右顶部:%d",i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        [bg addSubview:label];
    }
    return bg;
}

- (CGFloat)heightForHeadView:(TUADFFormView*)stockView{
     return 40.0f;
}


- (CGFloat)heightForCell:(TUADFFormView*)stockView indexPath:(NSIndexPath *)indexPath{
    return 30.0f;
}


- (void)updateCellStockView:(TUADFFormView*)stockView fixedView:(UIView*)fixedView leftContentView:(UIView*)leftView rightContentView:(UIView*)rightView rowPath:(NSUInteger)row{
    
    UILabel* label =(UILabel*) fixedView;
    label.text = [NSString stringWithFormat:@"分割:%ld",row];
    
    for (UILabel* label in leftView.subviews ) {
        label.text = [NSString stringWithFormat:@"左内容:%ld",row];
    }
    
    for (UILabel* label in rightView.subviews ) {
           label.text = [NSString stringWithFormat:@"右内容:%ld",row];
    }

}

- (void)didSelect:(TUADFFormView*)stockView rowPath:(NSUInteger)row{
    
}


#pragma mark - Get

- (TUADFFormView*)stockView{
    if(_stockView != nil){
        return _stockView;
    }
    _stockView = [TUADFFormView new];
    _stockView.dataSource = self;
    _stockView.delegate = self;
    return _stockView;
}


@end
