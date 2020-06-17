//
//  PaymentController.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "PaymentController.h"
@interface PaymentController()
@property(nonatomic,strong)NSMutableArray<PaymentModel *> *paymentArr;
@end

@implementation PaymentController
- (instancetype)init{
    if (self = [super init]) {
        self.paymentArr = [NSMutableArray array];
    }
    return self;
}

-(NSInteger)findPaymentWithId:(NSString *)productIdentifier{
    for (NSInteger i = 0;i < self.paymentArr.count;i++) {
        PaymentModel *model = self.paymentArr[i];
        if ([model.product.productIdentifier isEqualToString:productIdentifier]) {
            return i;
        }
    }
    return -1;
}

-(BOOL)hasPayment:(PaymentModel *)payment{
    return [self findPaymentWithId:payment.product.productIdentifier] != -1;
}

-(void)append:(PaymentModel *)payment{
    [self.paymentArr addObject:payment];
}

-(void)remove:(PaymentModel *)payment{
    NSInteger index = [self findPaymentWithId:payment.product.productIdentifier];
    if (index != -1) {
        [self.paymentArr removeObjectAtIndex:index];
    }
}

-(NSArray<SKPaymentTransaction *>*)handleTransactions:(NSArray<SKPaymentTransaction *>*)transactions paymentQueue:(SKPaymentQueue *)paymentQueue{
    NSMutableArray<SKPaymentTransaction *> *unhandle = [NSMutableArray array];
    
    for (SKPaymentTransaction *transaction  in transactions) {
        NSString *productIdentifier = transaction.payment.productIdentifier;
        NSInteger index = [self findPaymentWithId:productIdentifier];
        if (index == -1) {
            [unhandle addObject:transaction];
            continue;
        }
        PaymentModel *model = self.paymentArr[index];
        SKPaymentTransactionState state = transaction.transactionState;
        if (state == SKPaymentTransactionStatePurchased) {
            PaymentResult *result = [[PaymentResult alloc]initWithProduct:model.product transaction:transaction needFinish:!model.atomically];
            model.callback(result);
            if (model.atomically) {
                [paymentQueue finishTransaction:transaction];
            }
            model.callback = nil;
            [self.paymentArr removeObject:model];
            continue;
        }
        
        if (state == SKPaymentTransactionStateFailed) {
            PaymentResult *result = [[PaymentResult alloc]initWithProduct:model.product transaction:transaction needFinish:NO];
            result.isFailed = YES;
            result.error = transaction.error;
            model.callback(result);
            [paymentQueue finishTransaction:transaction];
            model.callback = nil;
            [self.paymentArr removeObject:model];
            continue;
        }
        
        if (state == SKPaymentTransactionStateRestored) {
            NSLog(@"不应该使用购买处理类来处理restore");
        }
        [unhandle addObject:transaction];
    }
    return [unhandle copy];
}

@end
