//
//  CompleteController.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "CompleteController.h"

@implementation CompleteController
- (NSArray<SKPaymentTransaction *> *)handleTransactions:(NSArray<SKPaymentTransaction *> *)transactions paymentQueue:(SKPaymentQueue *)paymentQueue{
    if (self.complete == nil) {return transactions;}
    NSMutableArray<SKPaymentTransaction *> *unhandle = [NSMutableArray array];
    NSMutableArray<PurchaseResult *> *purchases = [NSMutableArray array];
    for (SKPaymentTransaction *transaction in transactions) {
        if (transaction.transactionState == SKPaymentTransactionStatePurchasing) {
            [unhandle addObject:transaction];
            continue;
        }
        
        BOOL shouldFinish = self.complete.atomically || transaction.transactionState == SKPaymentTransactionStateFailed;
        
        PurchaseResult *result = [[PurchaseResult alloc]initWithTransaction:transaction needFinish:!shouldFinish];
        [purchases addObject:result];
        
        if (shouldFinish) {
            NSLog(@"finish 的订单 产品ID：%@ 订单状态：%ld",transaction.payment.productIdentifier,(long)transaction.transactionState);
            [paymentQueue finishTransaction:transaction];
        }
    }
    
    if (unhandle.count > 0) {
        CompleteResult *result = [[CompleteResult alloc]initWithResults:purchases];
        self.complete.callBack(result);
    }
    return unhandle;
}
@end
