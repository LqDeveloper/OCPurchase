//
//  CompleteController.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompleteModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CompleteController : NSObject
@property(nonatomic,strong)CompleteModel *complete;

- (NSArray<SKPaymentTransaction *> *)handleTransactions:(NSArray<SKPaymentTransaction *> *)transactions paymentQueue:(SKPaymentQueue *)paymentQueue;
@end

NS_ASSUME_NONNULL_END
