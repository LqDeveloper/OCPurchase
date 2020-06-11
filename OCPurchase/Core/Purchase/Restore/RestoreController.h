//
//  RestoreController.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestoreModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RestoreController : NSObject
@property(nonatomic,strong,nullable)RestoreModel *restore;

-(NSArray<SKPaymentTransaction *>*)handleTransactions:(NSArray<SKPaymentTransaction *>*)transactions paymentQueue:(SKPaymentQueue *)paymentQueue;

-(void)restoreCompletedTransactionsFailed:(NSError *)error;

-(void)restoreCompletedTransactionsFinished;
@end

NS_ASSUME_NONNULL_END
