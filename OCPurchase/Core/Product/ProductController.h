//
//  ProductController.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/5.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductController : NSObject
/// 向苹果请求产品信息
/// @param productIds 产品ID
/// @param completion 回调
-(void)requestWithProductIds:(NSArray<NSString *> *)productIds completion:(void(^)(ProductInfoModel * _Nonnull)) completion;

//取消请求
-(void)cancleWithProductIds:(NSArray<NSString *> *)productIds;

//取消所有请求
-(void)cancleAll;
@end

NS_ASSUME_NONNULL_END
