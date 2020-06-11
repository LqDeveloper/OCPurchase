//
//  ProductInfoRequest.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/5.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@class ProductInfoRequest;
@protocol ProductRequestDelegate <NSObject>

/// 请求产品成功
/// @param request 请求对象
/// @param products 请求到的产品
/// @param invalidIds 非法的ID
-(void)requestSuccessWithRequest:(ProductInfoRequest *_Nullable)request products:(NSArray<SKProduct*>*_Nullable)products invalidProductIDs:(NSArray <NSString *> *_Nullable)invalidIds;

/// 请求产品失败
/// @param request 请求对象
/// @param error error
-(void)requestFailureWithRequest:(ProductInfoRequest *_Nullable)request error:(NSError *_Nullable)error;

@end



NS_ASSUME_NONNULL_BEGIN

@interface ProductInfoRequest : NSObject

@property(nonatomic,copy,readonly)NSArray<NSString *> *productIds;

-(instancetype)initWithProductIds:(NSArray<NSString *>*)productIds delegate:(id<ProductRequestDelegate>)delegate;

//开始请求
-(void)start;

//取消请求
-(void)cancle;
@end

NS_ASSUME_NONNULL_END
