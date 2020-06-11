//
//  ReceiptController.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/10.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidateReceiptModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiptController : NSObject
@property(nonatomic,strong,readonly)NSData* receiptData;

- (void)requestReceipt:(BOOL)forceRefresh completion:(void (^)(NSData * _Nullable, NSError * _Nullable))completion;

- (void)requestReceipt:(void (^)(NSData * _Nullable, NSError * _Nullable))completion;

-(void)cancleReceiptRequest;

- (NSURLSessionDataTask *)validateWithType:(ReceiptValidatorType)type sharedSecret:(NSString *)sharedSecret excludeOldTransactions:(BOOL)excludeOldTransactions data:(NSData *)receiptData  completion:(void(^)(ValidateReceiptModel * _Nonnull))completion;


- (NSURLSessionDataTask *)validateWithType:(ReceiptValidatorType)type data:(NSData *)receiptData  completion:(void(^)(ValidateReceiptModel * _Nonnull))completion;

@end

NS_ASSUME_NONNULL_END
