# TUADFFormView

https://github.com/alucardulad/TUADFFormView/assets/6084007/242aca3e-e11f-4310-85c0-f2ec7c6784cc

简介
---
`TUADFFormView` 是一个用于期货/期权/股票场景的 T 型表格视图组件，灵感来自同花顺期货通的 T 型表。组件包含固定列与左右可滑动列，并提供委托接口用于自定义头部视图与数据展示。

主要特性
---
- 支持固定列与左右可滑动列的联合展示与滚动同步
- 提供可定制的头部视图（通过委托实现）
- 支持按行刷新与定位滚动（方便实时数据更新）
- 轻量 UIKit 实现，可直接集成到 iOS 项目中

目录结构（重要文件）
---
- `TTypeUpsAndDownsForm/`：组件源代码目录
  - [TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TUADFFormView.h](TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TUADFFormView.h)
  - [TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TUADFFormView.m](TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TUADFFormView.m)
  - [TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TUADFFormScrollView.h](TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TUADFFormScrollView.h)
  - [TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TUADFFormTableViewCell.h](TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/TUADFFormTableViewCell.h)
  - [TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/ViewController.h](TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/ViewController.h)

快速开始
---
1. 将 `TTypeUpsAndDownsForm` 目录添加到你的 Xcode 项目中。
2. 在需要的文件中导入头：

	```objc
	#import "TUADFFormView.h"
	```

3. 创建并添加到视图层级：

	```objc
	TUADFFormView *form = [[TUADFFormView alloc] initWithFrame:self.view.bounds];
	form.dataSource = self; // 实现对应的数据源协议
	form.delegate = self;   // 可选，提供自定义头部等
	[self.view addSubview:form];
	[form reloadStockView];
	```

API 概览
---
- 自定义头部：通过 `TUADFFormViewDelegate` 提供以下回调以替换不同位置的头部视图（示例）：`- (UIView*)headFixedView:(TUADFFormView*)stockView;`、`- (UIView*)headLeftView:(TUADFFormView*)stockView;`、`- (UIView*)headRightView:(TUADFFormView*)stockView;`
- 视图刷新与控制：`- (void)reloadStockView;`、`- (void)reloadStockViewFromRow:(NSUInteger)row;`、`- (void)scrollStockViewToRow:(NSUInteger)row;`

示例与演示
---
- 演示控制器位于 [TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/ViewController.h](TTypeUpsAndDownsForm/TTypeUpsAndDownsForm/ViewController.h)，可以参考其中的使用方式快速上手。

贡献与联系
---
- 如果觉得有用，欢迎点个 Star 支持。
- 问题或建议请发邮件至：alucardulad@gmail.com

许可
---
项目包含 `LICENSE` 文件，请查阅以了解许可详情。
