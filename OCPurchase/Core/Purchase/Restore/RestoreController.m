//
//  RestoreController.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "RestoreController.h"
@interface RestoreController()
@property(nonatomic,strong)NSMutableArray <PurchaseResult *> *restoredResults;
@end
@implementation RestoreController
- (instancetype)init{
    if (self = [super init]) {
        self.restoredResults = [NSMutableArray array];
    }
    return self;
}

- (NSArray<SKPaymentTransaction *> *)handleTransactions:(NSArray<SKPaymentTransaction *> *)transactions paymentQueue:(SKPaymentQueue *)paymentQueue{
    if (self.restore == nil) {return transactions;}
    NSMutableArray<SKPaymentTransaction *> *unhandle = [NSMutableArray array];
    
    for (SKPaymentTransaction *transaction in transactions) {
        if (transaction.transactionState == SKPaymentTransactionStateRestored) {
            PurchaseResult *result = [[PurchaseResult alloc]initWithTransaction:transaction needFinish:!self.restore.atomically];
            if (self.restore.atomically) {
                [paymentQueue finishTransaction:transaction];
            }
            [self.restoredResults addObject:result];
        }else{
            [unhandle addObject:transaction];
        }
    }
    return unhandle;
}
-(void)restoreCompletedTransactionsFailed:(NSError *)error{
    if (self.restore == nil) {
        NSLog(@"已经将restore数据返回了");
        return;
    }
    RestoreResult *restoreResult = [[RestoreResult alloc]initWithResults:[self.restoredResults copy]];
    restoreResult.error = error;
    restoreResult.isFailed = YES;
    self.restore.callBack(restoreResult);
    [self.restoredResults removeAllObjects];
    self.restore.callBack = nil;
    self.restore = nil;
}

-(void)restoreCompletedTransactionsFinished{
    if (self.restore == nil) {
        NSLog(@"已经将restore数据返回了");
        return;
    }
    RestoreResult *restoreResult = [[RestoreResult alloc]initWithResults:[self.restoredResults copy]];
    self.restore.callBack(restoreResult);
    [self.restoredResults removeAllObjects];
    self.restore.callBack = nil;
    self.restore = nil;
}

@end
