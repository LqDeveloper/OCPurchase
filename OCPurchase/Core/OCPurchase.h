//
//  OCPurchase.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/5.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductInfoModel.h"
#import "ValidateReceiptModel.h"
#import "PaymentResult.h"
#import "RestoreResult.h"
#import "CompleteResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface OCPurchase : NSObject
/// 是否允许购买
+(BOOL)canMakePayments;

/// 向苹果请求产品信息
/// @param productIds 产品ID
/// @param completion 回调
+(void)requestWithProductIds:(NSArray<NSString *> *)productIds completion:(void(^)(ProductInfoModel * _Nonnull)) completion;

//取消请求
+(void)cancleWithProductIds:(NSArray<NSString *> *)productIds;

//取消所有请求
+(void)cancleAllProductRequest;

/// Receipt
+(NSData *)receiptData;


/// 请求刷新Receipt
/// @param forceRefresh 是否强制刷新
/// @param completion 完成回调
+ (void)requestReceipt:(BOOL)forceRefresh completion:(void (^)(NSData * _Nullable, NSError * _Nullable))completion;


/// 请求刷新Receipt 如果本地存在receipt直接返回否则向苹果请求
/// @param completion 完成回调
+ (void)requestReceipt:(void (^)(NSData * _Nullable, NSError * _Nullable))completion;


/// 取消receipt请求
+(void)cancleReceiptRequest;

/// 验证receipt
/// @param type 是product还是sandbox
/// @param sharedSecret password
/// @param excludeOldTransactions 将此值设置为true，以使响应仅包括任何订阅的最新续订交易。仅对包含自动续订的应用收据使用此字段。
/// @param receiptData receipt
/// @param completion 完成回调
+ (NSURLSessionDataTask *)validateWithType:(ReceiptValidatorType)type sharedSecret:(NSString *)sharedSecret excludeOldTransactions:(BOOL)excludeOldTransactions data:(NSData *)receiptData  completion:(void(^)(ValidateReceiptModel * _Nonnull))completion;


/// 验证receipt
/// @param type 是product还是sandbox
/// @param receiptData receipt
/// @param completion 完成回调
+ (NSURLSessionDataTask *)validateWithType:(ReceiptValidatorType)type data:(NSData *)receiptData  completion:(void(^)(ValidateReceiptModel * _Nonnull))completion;

+(void)finishTransaction:(SKPaymentTransaction *)transaction;

/// 购买产品
/// @param product SKProducts
/// @param quantity quantity
/// @param atomically 是否自动finish
/// @param applicationUsername applicationUsername
/// @param simulatesAskToBuyInSandbox simulatesAskToBuyInSandbox
/// @param callback 回调
+(void)purchaseProduct:(SKProduct *)product quantity:(NSInteger)quantity atomically:(BOOL)atomically applicationUsername:(NSString*)applicationUsername simulatesAskToBuyInSandbox:(BOOL)simulatesAskToBuyInSandbox callback:(void(^)(PaymentResult * _Nonnull))callback;

/// 购买产品 默认不自动finish atomically 为NO 在将订单信息发送给后端成功的时候在finish
/// @param product SKProducts
/// @param callback 回调
+(void)purchaseProduct:(SKProduct *)product callback:(void(^)(PaymentResult * _Nonnull))callback;

/// restore
/// @param atomically 是否自动finish
/// @param applicationUsername applicationUsername
/// @param callBack 回调
+(void)restore:(BOOL)atomically applicationUsername:(NSString *)applicationUsername callBack:(void(^)(RestoreResult *))callBack;

/// restore 默认自动finish atomically 为YES
/// @param callBack 回调
+(void)restoreWithCallBack:(void(^)(RestoreResult *))callBack;

/// 应用启动时，返回没有处理的订单
/// @param atomically 是否自动finish
/// @param callBack 回调
+(void)complete:(BOOL)atomically callBack:(void(^)(CompleteResult*))callBack;

/// 应用启动时，返回没有处理的订单 默认自动finish atomically 为YES
/// @param callBack 回调
+(void)completeWithCallBack:(void(^)(CompleteResult*))callBack;

//下载相关
+(void)shouldAddStorePaymentHandler:(BOOL(^)(SKPayment *,SKProduct *))block;

+(void)updatedDownloadsHandler:(void(^)(NSArray<SKDownload *> *))block;

+(void)start:(NSArray <SKDownload *>*)downloads;

+(void)pause:(NSArray <SKDownload *>*)downloads;

+(void)resume:(NSArray <SKDownload *>*)downloads;

+(void)cancel:(NSArray <SKDownload *>*)downloads;
@end

NS_ASSUME_NONNULL_END
