//
//  PurchaseResult.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "PurchaseResult.h"

@implementation PurchaseResult
- (instancetype)initWithTransaction:(SKPaymentTransaction *)transaction needFinish:(BOOL)needFinish{
    if (self = [super init]) {
        self.transaction = transaction;
        self.needFinish = needFinish;
    }
    return self;
}

- (SKErrorCode)errorCode{
    return (SKErrorCode)self.transaction.error.code;
}


-(SKPaymentTransaction *)originalTransaction{
    return self.transaction.originalTransaction;
}

- (NSDate *)transactionDate{
    return self.transaction.transactionDate;
}

- (NSString *)transactionIdentifier{
    return self.transaction.transactionIdentifier;
}

- (SKPaymentTransactionState)transactionState{
    return self.transaction.transactionState;
}

- (NSString *)productIdentifier{
    return self.transaction.payment.productIdentifier;
}
@end
