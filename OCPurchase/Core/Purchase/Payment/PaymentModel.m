//
//  PaymentModel.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "PaymentModel.h"

@implementation PaymentModel
-(instancetype)initWithProduct:(SKProduct *)product atomically:(BOOL)atomically quantity:(NSInteger)quantity applicationUsername:(NSString *)applicationUsername simulatesAskToBuyInSandbox:(BOOL)simulatesAskToBuyInSandbox callback:(void (^)(PaymentResult * _Nonnull))callback{
    if (self = [super init]) {
        self.product = product;
        self.atomically = atomically;
        self.quantity = quantity;
        self.applicationUsername = applicationUsername;
        self.simulatesAskToBuyInSandbox = simulatesAskToBuyInSandbox;
        self.callback = callback;
    }
    return self;
}
@end
