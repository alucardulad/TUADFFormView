//
//  TUADFFormScrollView.h
//  TTypeUpsAndDownsForm
//
//  Created by suhongyi on 2023/8/28.
//  Copyright © 2023 alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    TUADFFormScrollViewLeft,
    TUADFFormScrollViewRight
} TUADFFormScrollViewType;

NS_ASSUME_NONNULL_BEGIN

@interface TUADFFormScrollView : UIScrollView
@property (nonatomic , assign) TUADFFormScrollViewType viewType;
@end

NS_ASSUME_NONNULL_END
