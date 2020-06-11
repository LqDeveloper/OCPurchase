//
//  PaymentResult.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PaymentResult : NSObject
@property(nonatomic,strong,nonnull)SKProduct *product;
@property(nonatomic,strong,nullable)SKPaymentTransaction *transaction;
@property(nonatomic,assign)BOOL needFinish;


@property(nonatomic,assign)SKErrorCode errorCode;
@property(nonatomic, readonly, nullable) SKPaymentTransaction *originalTransaction;
@property(nonatomic, readonly, nullable) NSDate *transactionDate;
@property(nonatomic, readonly, nullable) NSString *transactionIdentifier;
@property(nonatomic, readonly) SKPaymentTransactionState transactionState;
@property(nonatomic, copy, readonly) NSString *productIdentifier;

//通过这个属性来判断购买是否失败
@property(nonatomic,assign)BOOL isFailed;
@property(nonatomic,strong,nullable)NSError *error;

-(instancetype)initWithProduct:(SKProduct *)product transaction:(SKPaymentTransaction *)transaction needFinish:(BOOL)needFinish;
@end

NS_ASSUME_NONNULL_END
