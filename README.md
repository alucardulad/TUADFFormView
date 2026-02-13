# TUADFFormView

![Platform](https://img.shields.io/badge/platform-iOS%2011.0%2B-blue.svg)
![Swift](https://img.shields.io/badge/swift-ObjectiveC%20Native-orange.svg)
![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)
![Language](https://img.shields.io/badge/language-ObjectiveC-purple.svg)
![Version](https://img.shields.io/badge/version-1.0.0-green.svg)

<div align="center">

**优雅的 iOS 期货/期权/股票 T 型表格视图组件**
**固定列 + 左右独立滚动，完全可定制**

[功能特性](#-功能特性) • [快速开始](#-快速开始) • [使用示例](#-使用示例) • [API 文档](#-api-文档) • [配置选项](#-配置选项)

</div>

---

## 📖 项目简介

`TUADFFormView` 是一个专门为**期货、期权、股票交易场景**设计的 T 型表格视图组件，灵感来自同花顺期货通的 T 型表。

该组件采用**纯 UIKit 实现**，支持**固定列与左右独立可滑动列**的联合展示。通过**委托协议**提供完全的 UI 定制能力，同时支持**增量数据更新**和**定位滚动**，非常适合实时数据驱动的金融类应用。

### 核心特性

- ✅ **T 型布局** - 固定列 + 左右独立滚动列
- ✅ **独立滚动同步** - 左右列可独立滚动，保持各自滚动位置
- ✅ **完全可定制** - 通过委托协议自定义所有 UI 元素
- ✅ **增量更新** - 支持按行刷新和定位滚动
- ✅ **轻量 UIKit** - 无第三方依赖，易于集成
- ✅ **实时数据** - 适配高频数据更新场景
- ✅ **协议驱动** - 数据源 + 代理，架构清晰

---

## 🎯 功能特性详解

### 1. T 型布局结构

```
┌─────────────────────────────────────────────────────┐
│               固定列头部（可自定义）                 │
├──────────────┬──────────────────┬──────────────────┤
│              │                  │                  │
│    固定列    │    左侧滚动列    │    右侧滚动列    │
│   (固定不动) │   (可左右滑动)   │   (可左右滑动)   │
│              │   显示多列数据    │   显示多列数据    │
│              │                  │                  │
├──────────────┴──────────────────┴──────────────────┤
│            固定列内容区域（30 行示例）               │
│            ├─ 每行包含固定列 + 左右内容             │
│            ├─ 左右内容可独立滚动                     │
│            └─ 固定列始终固定不动                     │
└─────────────────────────────────────────────────────┘
```

**布局特点：**

- **固定列**：中间列始终固定，不随滚动移动
- **左侧列**：支持左右滑动，展示更多列数据
- **右侧列**：支持左右滑动，展示更多列数据
- **独立滚动**：左右列可独立滚动，互不干扰
- **同步恢复**：切换行时自动恢复上次滚动位置

### 2. 自定义头部视图

通过 `TUADFFormViewDelegate` 提供多个自定义头部接口：

#### 固定列头部
```objc
- (UIView*)headFixedView:(TUADFFormView*)stockView;
```
自定义固定列的顶部标题视图。

#### 左侧头部视图
```objc
- (UIView*)headLeftView:(TUADFFormView*)stockView;
```
自定义左侧列的顶部标题视图。

#### 右侧头部视图
```objc
- (UIView*)headRightView:(TUADFFormView*)stockView;
```
自定义右侧列的顶部标题视图。

#### 统一高度配置
```objc
- (CGFloat)heightForHeadView:(TUADFFormView*)stockView;
```
返回所有头部的统一高度。

### 3. 单元格内容自定义

通过 `TUADFFormViewDataSource` 提供完整的单元格内容控制：

#### 固定列内容
```objc
- (UIView*)cellFixedViewForStockView:(TUADFFormView*)stockView;
```
返回固定列每行的自定义视图。

#### 左侧内容视图
```objc
- (UIView*)cellLeftContentForStockView:(TUADFFormView*)stockView;
```
返回左侧列每行的自定义视图。

#### 右侧内容视图
```objc
- (UIView*)cellRightContentForStockView:(TUADFFormView*)stockView;
```
返回右侧列每行的自定义视图。

### 4. 数据更新机制

#### 全量刷新
```objc
- (void)reloadStockView;
```
刷新所有单元格内容。

#### 增量刷新
```objc
- (void)reloadStockViewFromRow:(NSUInteger)row;
```
仅刷新指定行，保持滚动位置不变。

#### 定位滚动
```objc
- (void)scrollStockViewToRow:(NSUInteger)row;
```
滚动到指定行并恢复左右列的滚动位置。

#### 数据更新回调
```objc
- (void)updateCellStockView:(TUADFFormView*)stockView
            fixedView:(UIView*)fixedView
    leftContentView:(UIView*)leftView
   rightContentView:(UIView*)rightView
            rowPath:(NSUInteger)row;
```
更新指定行的单元格数据，用于实时数据更新。

### 5. 实时数据更新示例

```objc
// 实时更新第 10 行的数据
[formView updateCellStockView:formView
                 fixedView:fixedView
         leftContentView:leftView
        rightContentView:rightView
                 rowPath:10];

// 刷新第 10 行
[formView reloadStockViewFromRow:10];

// 滚动到第 10 行
[formView scrollStockViewToRow:10];
```

---

## 🚀 快速开始

### 安装

#### 方法一：手动集成

1. 将 `TTypeUpsAndDownsForm` 目录复制到你的 Xcode 项目中

2. 在需要的文件中导入头文件：
   ```objc
   #import "TUADFFormView.h"
   ```

3. 确保项目支持 **iOS 11.0+**

#### 方法二：示例项目

参考项目中的 `ViewController` 文件：
```objc
#import "ViewController.h"
#import "TUADFFormView.h"
```

---

## 📚 使用示例

### 示例 1：基础 T 型表

```objc
#import "TUADFFormView.h"

@interface TradingViewController () <TUADFFormViewDelegate, TUADFFormViewDataSource>
@property (nonatomic, strong) TUADFFormView *formView;
@property (nonatomic, assign) NSInteger headerType;  // 0:默认, 1:左侧展开, 2:右侧展开
@end

@implementation TradingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建 T 型表视图
    self.formView = [[TUADFFormView alloc] initWithFrame:self.view.bounds];
    self.formView.dataSource = self;
    self.formView.delegate = self;
    [self.view addSubview:self.formView];

    // 初始加载
    [self.formView reloadStockView];
}

#pragma mark - TUADFFormViewDataSource

// 1. 返回总行数
- (NSUInteger)countForStockView:(TUADFFormView *)stockView {
    return 100;  // 假设有 100 行数据
}

// 2. 固定列每行的视图
- (UIView *)cellFixedViewForStockView:(TUADFFormView *)stockView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"合约代码";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

// 3. 左侧列每行的视图
- (UIView *)cellLeftContentForStockView:(TUADFFormView *)stockView {
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 30)];

    // 模拟显示 8 列数据
    for (NSInteger i = 0; i < 8; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        label.text = [NSString stringWithFormat:@"左侧列%d", i];
        label.textAlignment = NSTextAlignmentCenter;
        [content addSubview:label];
    }
    return content;
}

// 4. 右侧列每行的视图
- (UIView *)cellRightContentForStockView:(TUADFFormView *)stockView {
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 30)];

    // 模拟显示 8 列数据
    for (NSInteger i = 0; i < 8; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        label.text = [NSString stringWithFormat:@"右侧列%d", i];
        label.textAlignment = NSTextAlignmentCenter;
        [content addSubview:label];
    }
    return content;
}

// 5. 更新单元格数据（实时数据更新时调用）
- (void)updateCellStockView:(TUADFFormView *)stockView
                 fixedView:(UIView *)fixedView
         leftContentView:(UIView *)leftView
        rightContentView:(UIView *)rightView
                 rowPath:(NSUInteger)row {
    // 更新固定列数据
    if ([fixedView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)fixedView;
        label.text = [NSString stringWithFormat:@"合约%lu", row];
    }

    // 更新左侧列数据
    if ([leftView isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)leftView;
        // 重新创建内容...
    }

    // 更新右侧列数据
    if ([rightView isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)rightView;
        // 重新创建内容...
    }
}

#pragma mark - TUADFFormViewDelegate

// 1. 固定列头部视图
- (UIView *)headFixedView:(TUADFFormView *)stockView {
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    header.text = @"合约代码";
    header.textAlignment = NSTextAlignmentCenter;
    header.backgroundColor = [UIColor whiteColor];
    header.textColor = [UIColor grayColor];
    return header;
}

// 2. 左侧头部视图
- (UIView *)headLeftView:(TUADFFormView *)stockView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 40)];

    for (NSInteger i = 0; i < 8; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 40)];
        label.text = [NSString stringWithFormat:@"左侧列%d", i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        [header addSubview:label];
    }
    return header;
}

// 3. 右侧头部视图
- (UIView *)headRightView:(TUADFFormView *)stockView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 40)];

    for (NSInteger i = 0; i < 8; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 40)];
        label.text = [NSString stringWithFormat:@"右侧列%d", i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        [header addSubview:label];
    }
    return header;
}

// 4. 头部统一高度
- (CGFloat)heightForHeadView:(TUADFFormView *)stockView {
    return 40.0f;
}

// 5. 单元格高度
- (CGFloat)heightForCell:(TUADFFormView *)stockView indexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}

// 6. 点击行事件
- (void)didSelect:(TUADFFormView *)stockView rowPath:(NSUInteger)row {
    NSLog(@"点击了第 %lu 行", row);

    // 跳转到详情页
    // TradingDetailViewController *detailVC = [[TradingDetailViewController alloc] init];
    // [self.navigationController pushViewController:detailVC animated:YES];
}

@end
```

### 示例 2：实时行情更新

```objc
@interface LiveTradingViewController ()

@property (nonatomic, strong) TUADFFormView *formView;
@property (nonatomic, strong) NSTimer *updateTimer;

@end

@implementation LiveTradingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.formView = [[TUADFFormView alloc] initWithFrame:self.view.bounds];
    self.formView.dataSource = self;
    self.formView.delegate = self;
    [self.view addSubview:self.formView];

    // 加载初始数据
    [self.formView reloadStockView];

    // 启动定时器，每 1 秒更新一次数据
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(updateData)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)updateData {
    // 获取最新的行情数据
    NSArray *latestData = [self fetchLatestDataFromServer];

    // 更新每一行的数据
    for (NSInteger i = 0; i < latestData.count; i++) {
        NSDictionary *data = latestData[i];

        // 提取左右列内容
        UIView *fixedView = [self createFixedViewWith:data];
        UIView *leftView = [self createLeftViewWith:data];
        UIView *rightView = [self createRightViewWith:data];

        // 更新数据
        [self.formView updateCellStockView:self.formView
                                 fixedView:fixedView
                         leftContentView:leftView
                        rightContentView:rightView
                                 rowPath:i];
    }

    // 刷新显示（保持滚动位置）
    [self.formView reloadStockViewFromRow:0];
}

- (NSArray *)fetchLatestDataFromServer {
    // 从服务器获取最新数据
    return @[@{@"price": @"5.20", @"change": @"0.50", ...},
             @{@"price": @"5.25", @"change": @"0.55", ...},
             // ...更多数据
            ];
}

- (UIView *)createFixedViewWith:(NSDictionary *)data {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = data[@"code"];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UIView *)createLeftViewWith:(NSDictionary *)data {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 30)];
    // 创建左侧列内容...
    return view;
}

- (UIView *)createRightViewWith:(NSDictionary *)data {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 30)];
    // 创建右侧列内容...
    return view;
}

- (void)dealloc {
    [self.updateTimer invalidate];
}

@end
```

### 示例 3：左侧展开/右侧展开切换

```objc
- (void)showLeftSideExpand {
    // 切换到左侧展开模式
    self.headerType = 1;

    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateStockContentViewFrame"
                                                        object:nil
                                                      userInfo:@{@"type": @1}];

    // 刷新视图
    [self.formView reloadStockView];
}

- (void)showRightSideExpand {
    // 切换到右侧展开模式
    self.headerType = 2;

    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateStockContentViewFrame"
                                                        object:nil
                                                      userInfo:@{@"type": @2}];

    // 刷新视图
    [self.formView reloadStockView];
}
```

---

## 📖 API 文档

### TUADFFormView 主类

#### 初始化

```objc
- (instancetype)initWithFrame:(CGRect)frame;
```

**参数：**
- `frame`：视图的初始 frame

**示例：**
```objc
TUADFFormView *form = [[TUADFFormView alloc] initWithFrame:self.view.bounds];
```

#### 属性

```objc
// 数据源
@property(nonatomic, readwrite, weak) id<TUADFFormViewDataSource> dataSource;

// 代理
@property(nonatomic, readwrite, weak) id<TUADFFormViewDelegate> delegate;

// 内部 UITableView（只读）
@property(nonatomic, readonly, weak) UITableView *tStockTableView;
```

#### 公共方法

##### 1. 刷新全部
```objc
- (void)reloadStockView;
```
刷新所有单元格内容，重新布局视图。

**示例：**
```objc
[formView reloadStockView];
```

##### 2. 增量刷新指定行
```objc
- (void)reloadStockViewFromRow:(NSUInteger)row;
```

**参数：**
- `row`：要刷新的行索引（从 0 开始）

**特点：**
- 仅刷新指定行
- 保持滚动位置不变
- 保持左右列滚动位置不变

**示例：**
```objc
[formView reloadStockViewFromRow:10];
```

##### 3. 定位滚动到指定行
```objc
- (void)scrollStockViewToRow:(NSUInteger)row;
```

**参数：**
- `row`：要滚动到的行索引（从 0 开始）

**特点：**
- 滚动到指定行
- 恢复左右列的滚动位置
- 默认滚动到顶部

**示例：**
```objc
[formView scrollStockViewToRow:25];
```

---

### 协议定义

#### TUADFFormViewDelegate（代理协议）

代理方法都是可选的，实现需要的功能即可。

##### 固定列头部视图
```objc
- (UIView*)headFixedView:(TUADFFormView*)stockView;
```

**职责：** 自定义固定列的顶部标题视图

**示例：**
```objc
- (UIView*)headFixedView:(TUADFFormView *)stockView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"固定列标题";
    return label;
}
```

##### 左侧头部视图
```objc
- (UIView*)headLeftView:(TUADFFormView*)stockView;
```

**职责：** 自定义左侧列的顶部标题视图

**示例：**
```objc
- (UIView*)headLeftView:(TUADFFormView *)stockView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 40)];
    // 添加子视图...
    return header;
}
```

##### 右侧头部视图
```objc
- (UIView*)headRightView:(TUADFFormView*)stockView;
```

**职责：** 自定义右侧列的顶部标题视图

**示例：**
```objc
- (UIView*)headRightView:(TUADFFormView *)stockView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 40)];
    // 添加子视图...
    return header;
}
```

##### 头部统一高度
```objc
- (CGFloat)heightForHeadView:(TUADFFormView*)stockView;
```

**职责：** 返回所有头部的统一高度

**参数：**
- `stockView`：TUADFFormView 实例

**返回值：** 头部的高度（像素）

**示例：**
```objc
- (CGFloat)heightForHeadView:(TUADFFormView *)stockView {
    return 40.0f;  // 头部高度 40 点
}
```

##### 单元格高度
```objc
- (CGFloat)heightForCell:(TUADFFormView*)stockView indexPath:(NSIndexPath *)indexPath;
```

**职责：** 返回指定行的单元格高度

**参数：**
- `stockView`：TUADFFormView 实例
- `indexPath`：单元格的路径（目前仅支持单 Section）

**返回值：** 单元格高度（像素）

**示例：**
```objc
- (CGFloat)heightForCell:(TUADFFormView *)stockView indexPath:(NSIndexPath *)indexPath {
    return 30.0f;  // 每行高度 30 点
}
```

##### 点击行事件
```objc
- (void)didSelect:(TUADFFormView*)stockView rowPath:(NSUInteger)row;
```

**职责：** 处理点击行的事件

**参数：**
- `stockView`：TUADFFormView 实例
- `row`：被点击的行索引

**示例：**
```objc
- (void)didSelect:(TUADFFormView *)stockView rowPath:(NSUInteger)row {
    NSLog(@"点击了第 %lu 行", row);

    // 跳转到详情页
    TradingDetailViewController *detailVC = [[TradingDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}
```

---

#### TUADFFormViewDataSource（数据源协议）

数据源方法是必需的，实现需要的数据提供即可。

##### 返回总行数
```objc
- (NSUInteger)countForStockView:(TUADFFormView*)stockView;
```

**职责：** 返回表格的总行数

**参数：**
- `stockView`：TUADFFormView 实例

**返回值：** 总行数

**示例：**
```objc
- (NSUInteger)countForStockView:(TUADFFormView *)stockView {
    return 100;  // 假设有 100 行数据
}
```

##### 固定列内容视图
```objc
- (UIView*)cellFixedViewForStockView:(TUADFFormView*)stockView;
```

**职责：** 返回固定列每行的自定义视图

**参数：**
- `stockView`：TUADFFormView 实例

**返回值：** 自定义的视图（通常包含固定列的标签或图标）

**示例：**
```objc
- (UIView *)cellFixedViewForStockView:(TUADFFormView *)stockView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"合约";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    return label;
}
```

##### 左侧内容视图
```objc
- (UIView*)cellLeftContentForStockView:(TUADFFormView*)stockView;
```

**职责：** 返回左侧列每行的自定义视图

**参数：**
- `stockView`：TUADFFormView 实例

**返回值：** 自定义的视图（包含左侧列的多列数据）

**示例：**
```objc
- (UIView *)cellLeftContentForStockView:(TUADFFormView *)stockView {
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 30)];

    // 创建 8 列数据
    for (NSInteger i = 0; i < 8; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        label.text = [NSString stringWithFormat:@"列%d", i];
        label.textAlignment = NSTextAlignmentCenter;
        [content addSubview:label];
    }
    return content;
}
```

##### 右侧内容视图
```objc
- (UIView*)cellRightContentForStockView:(TUADFFormView*)stockView;
```

**职责：** 返回右侧列每行的自定义视图

**参数：**
- `stockView`：TUADFFormView 实例

**返回值：** 自定义的视图（包含右侧列的多列数据）

**示例：**
```objc
- (UIView *)cellRightContentForStockView:(TUADFFormView *)stockView {
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 30)];

    // 创建 8 列数据
    for (NSInteger i = 0; i < 8; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        label.text = [NSString stringWithFormat:@"列%d", i];
        label.textAlignment = NSTextAlignmentCenter;
        [content addSubview:label];
    }
    return content;
}
```

##### 更新单元格数据
```objc
- (void)updateCellStockView:(TUADFFormView*)stockView
                 fixedView:(UIView*)fixedView
         leftContentView:(UIView*)leftView
        rightContentView:(UIView*)rightView
                 rowPath:(NSUInteger)row;
```

**职责：** 更新指定行的单元格数据（用于实时数据更新）

**参数：**
- `stockView`：TUADFFormView 实例
- `fixedView`：固定列的视图
- `leftView`：左侧列的视图
- `rightView`：右侧列的视图
- `row`：行索引

**使用场景：** 实时行情数据更新时，通过此方法更新单元格内容，避免全量刷新。

**示例：**
```objc
- (void)updateCellStockView:(TUADFFormView *)stockView
                 fixedView:(UIView *)fixedView
         leftContentView:(UIView *)leftView
        rightContentView:(UIView *)rightView
                 rowPath:(NSUInteger)row {

    // 更新固定列
    if ([fixedView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)fixedView;
        label.text = [NSString stringWithFormat:@"合约%lu", row];
    }

    // 更新左侧列
    if ([leftView isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)leftView;
        // 重新创建左侧列内容...
    }

    // 更新右侧列
    if ([rightView isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)rightView;
        // 重新创建右侧列内容...
    }
}
```

---

## 🏗️ 项目结构

```
TTypeUpsAndDownsForm/
├── TTypeUpsAndDownsForm/                 # 组件源码目录
│   ├── TUADFFormView.h                   # 主视图控制器头文件
│   ├── TUADFFormView.m                   # 主视图控制器实现
│   ├── TUADFFormScrollView.h             # 可滚动视图头文件
│   ├── TUADFFormScrollView.m             # 可滚动视图实现
│   ├── TUADFFormTableViewCell.h         # 单元格视图头文件
│   ├── TUADFFormTableViewCell.m         # 单元格视图实现
│   ├── ViewController.h                  # 示例控制器头文件
│   ├── ViewController.m                  # 示例控制器实现
│   ├── AppDelegate.h                     # 应用代理
│   ├── AppDelegate.m                     # 应用代理实现
│   ├── SceneDelegate.h                   # 场景代理
│   ├── SceneDelegate.m                   # 场景代理实现
│   ├── main.m                            # 主入口
│   ├── Assets.xcassets                   # 资源文件
│   └── Base.lproj/                        # Storyboard 资源
├── TTypeUpsAndDownsForm.xcodeproj        # Xcode 项目文件
├── README.md                             # 项目文档
└── LICENSE                               # 许可证
```

### 核心模块说明

| 模块 | 文件 | 职责 |
|------|------|------|
| **TUADFFormView** | TUADFFormView.h/.m | 主视图控制器，管理 T 型表整体布局和交互 |
| **TUADFFormScrollView** | TUADFFormScrollView.h/.m | 可滚动内容视图，支持左右独立滚动 |
| **TUADFFormTableViewCell** | TUADFFormTableViewCell.h/.m | 单元格视图，包含固定列 + 左右内容容器 |
| **ViewController** | ViewController.h/.m | 演示控制器，展示组件使用方式 |

---

## ⚙️ 配置选项

### 数据量配置

```objc
// 在 dataSource 中实现
- (NSUInteger)countForStockView:(TUADFFormView *)stockView {
    return 1000;  // 设置总行数（建议 100-500 行，过多会影响性能）
}
```

### 列宽配置

```objc
// 在数据源方法中返回的视图中设置
- (UIView *)cellLeftContentForStockView:(TUADFFormView *)stockView {
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 30)];

    // 左侧列总宽度 800 点，分为 8 列，每列 100 点
    for (NSInteger i = 0; i < 8; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        // ...
    }
    return content;
}
```

### 颜色配置

```objc
// 在 delegate 或 dataSource 方法中配置颜色
- (UIView *)cellFixedViewForStockView:(TUADFFormView *)stockView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.textColor = [UIColor systemGrayColor];  // 系统灰色
    label.backgroundColor = [UIColor lightGrayColor];  // 浅灰色背景
    return label;
}
```

---

## ⚠️ 注意事项

### 1. 性能优化

**建议：**
- 单元格高度固定，避免频繁计算
- 大数据量时（>1000 行）考虑使用虚拟滚动
- 实时更新时使用 `updateCellStockView` 而非全量刷新
- 懒加载：仅创建可见区域的视图

**避免：**
- 在 `updateCellStockView` 中创建新视图对象
- 频繁调用 `reloadStockView`
- 过多嵌套的视图层级

### 2. 滚动同步

**注意：**
- 左右列滚动位置会保存，切换行时自动恢复
- 确保左右列内容宽度一致，避免错位
- 左右列可以独立滚动，但保持各自位置

### 3. 数据源协议

**要求：**
- 必须实现 `countForStockView`
- 必须实现 `cellFixedViewForStockView`
- 其他方法为可选

**示例：**
```objc
- (NSUInteger)countForStockView:(TUADFFormView *)stockView {
    return 100;  // 必须实现
}

- (UIView *)cellFixedViewForStockView:(TUADFFormView *)stockView {
    return [[UILabel alloc] initWithFrame:CGRectZero];  // 必须实现
}

- (UIView *)cellLeftContentForStockView:(TUADFFormView *)stockView {
    return [[UIView alloc] initWithFrame:CGRectZero];  // 可选实现
}
```

### 4. 内存管理

**建议：**
- 及时释放不再需要的视图对象
- 使用 `weak` 引用避免循环引用
- 在 `dealloc` 中清理定时器等资源

**示例：**
```objc
- (void)dealloc {
    [self.updateTimer invalidate];
}
```

### 5. 实时更新

**推荐方式：**
```objc
// 1. 更新单个单元格的数据
- (void)updateCellStockView:... {
    // 更新视图内容...
}

// 2. 刷新指定行（保持滚动位置）
[formView reloadStockViewFromRow:10];
```

**避免：**
```objc
// ❌ 频繁调用全量刷新
[self.formView reloadStockView];  // 每秒调用 60 次会严重影响性能
```

---

## 🔄 高级用法

### 1. 支持横屏/竖屏切换

```objc
- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    // 重新布局表视图
    [UIView animateWithDuration:coordinator.animationDuration animations:^{
        self.formView.frame = self.view.bounds;
        [self.formView layoutIfNeeded];
    }];
}
```

### 2. 动态调整列宽

```objc
- (void)adjustColumnWidth:(NSInteger)columnIndex width:(CGFloat)width {
    // 遍历所有行，更新左侧或右侧列的内容视图
    for (NSInteger row = 0; row < [self.formView countForStockView:self.formView]; row++) {
        UIView *contentView = [self.formView cellLeftContentForStockView:self.formView];

        // 更新列宽...
    }

    // 刷新显示
    [self.formView reloadStockView];
}
```

### 3. 通知监听

```objc
// 监听列宽变化通知
[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleColumnWidthChange:)
                                                 name:@"UpdateStockContentViewFrame"
                                               object:nil];

- (void)handleColumnWidthChange:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSInteger type = [userInfo[@"type"] integerValue];

    if (type == 1) {
        // 左侧展开
        // 更新列宽...
    } else if (type == 2) {
        // 右侧展开
        // 更新列宽...
    }

    // 刷新视图
    [self.formView reloadStockView];
}
```

---

## 📄 许可证

本项目采用 [MIT 许可证](LICENSE)。

```
MIT License

Copyright (c) 2023 Alucardulad

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

### 提交 Pull Request 的步骤

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'feat: Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

### 代码规范

- 遵循 Objective-C 代码规范
- 添加适当的注释和文档
- 编写单元测试
- 保持代码简洁可读

---

## 📞 联系方式

- **作者**: alucardulad
- **邮箱**: alucardulad@gmail.com
- **主页**: https://github.com/alucardulad/TUADFFormView

---

## 🌟 Star History

如果这个项目对你有帮助，请给个 ⭐ Star 支持一下！

<div align="center">

**Made with ❤️ by alucardulad**

</div>
