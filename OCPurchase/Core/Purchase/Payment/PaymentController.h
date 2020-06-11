//
//  PaymentController.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "PaymentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PaymentController : NSObject
-(void)append:(PaymentModel *)payment;

-(void)remove:(PaymentModel *)payment;

-(BOOL)hasPayment:(PaymentModel *)payment;

-(NSArray<SKPaymentTransaction *>*)handleTransactions:(NSArray<SKPaymentTransaction *>*)transactions paymentQueue:(SKPaymentQueue *)paymentQueue;
@end

NS_ASSUME_NONNULL_END
