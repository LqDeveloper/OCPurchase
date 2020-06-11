//
//  PurchaseController.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/10.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "PurchaseController.h"
#import "PaymentController.h"
#import "RestoreController.h"
#import "CompleteController.h"
@interface PurchaseController()<SKPaymentTransactionObserver>
@property(nonatomic,weak)SKPaymentQueue* paymentQueue;
@property(nonatomic,strong)PaymentController *paymentController;
@property(nonatomic,strong)RestoreController *restoreController;
@property(nonatomic,strong)CompleteController *completeController;
@end
@implementation PurchaseController
- (instancetype)init{
    if (self = [super init]) {
        self.paymentQueue = [SKPaymentQueue defaultQueue];
        [self.paymentQueue addTransactionObserver:self];
        self.paymentController = [[PaymentController alloc]init];
        self.restoreController = [[RestoreController alloc]init];
        self.completeController = [[CompleteController alloc]init];
    }
    return self;
}

- (void)dealloc{
    [self.paymentQueue removeTransactionObserver:self];
    self.paymentQueue = nil;
    self.paymentController = nil;
    self.restoreController = nil;
    self.completeController = nil;
}

-(void)startPayment:(PaymentModel *)payment{
    [self assertCompleteTransactionsWasCalled];
    SKMutablePayment *skPayment = [SKMutablePayment paymentWithProduct:payment.product];
    skPayment.applicationUsername = payment.applicationUsername;
    skPayment.quantity = payment.quantity;
    skPayment.simulatesAskToBuyInSandbox = payment.simulatesAskToBuyInSandbox;
    [self.paymentQueue addPayment:skPayment];
    [self.paymentController append:payment];
}

-(void)restore:(RestoreModel *)restoreModel{
    [self assertCompleteTransactionsWasCalled];
    if (self.restoreController.restore != nil) {
        return;
    }
    [self.paymentQueue restoreCompletedTransactionsWithApplicationUsername:restoreModel.applicationUsername];
    self.restoreController.restore = restoreModel;
}

-(void)complete:(CompleteModel *)complete{
    if (self.completeController.complete != nil) {
        NSLog(@"complete 已经设置过来");
        return;
    }
    self.completeController.complete = complete;
}

-(void)finishTransaction:(SKPaymentTransaction *)transaction{
    [self.paymentQueue finishTransaction:transaction];
}

-(void)start:(NSArray <SKDownload *>*)downloads{
    [self.paymentQueue startDownloads:downloads];
}

-(void)pause:(NSArray <SKDownload *>*)downloads{
    [self.paymentQueue pauseDownloads:downloads];
}

-(void)resume:(NSArray <SKDownload *>*)downloads{
    [self.paymentQueue resumeDownloads:downloads];
}

-(void)cancel:(NSArray <SKDownload *>*)downloads{
    [self.paymentQueue cancelDownloads:downloads];
}

-(void)assertCompleteTransactionsWasCalled{
    NSAssert(YES, @"completeTransactions() 在应用启动的时候回去调用");
}

- (void)paymentQueue:(nonnull SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions {
    NSArray *unhandle = [self.paymentController handleTransactions:transactions paymentQueue:queue];
    unhandle = [self.restoreController handleTransactions:unhandle paymentQueue:queue];
    unhandle = [self.completeController handleTransactions:unhandle paymentQueue:queue];
    if (unhandle.count > 0) {
        for (SKPaymentTransaction *trans in transactions) {
            NSLog(@"没有处理的订单 产品ID: %@ 订单状态: %ld",trans.payment.productIdentifier,(long)trans.transactionState);
        }
    }
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
    [self.restoreController restoreCompletedTransactionsFinished];
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    [self.restoreController restoreCompletedTransactionsFailed:error];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray<SKDownload *> *)downloads{
    if (self.updatedDownloadsHandler) {
        self.updatedDownloadsHandler(downloads);
    }
}

- (BOOL)paymentQueue:(SKPaymentQueue *)queue shouldAddStorePayment:(SKPayment *)payment forProduct:(SKProduct *)product API_AVAILABLE(ios(11.0)){
    if (self.shouldAddStorePaymentHandler) {
        return self.shouldAddStorePaymentHandler(payment, product);
    }else{
        return NO;
    }
}
@end
