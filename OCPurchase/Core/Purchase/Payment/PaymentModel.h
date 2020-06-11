//
//  PaymentModel.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaymentResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface PaymentModel : NSObject
@property(nonatomic,strong,nonnull)SKProduct *product;
@property(nonatomic,assign)BOOL atomically;
@property(nonatomic,assign)NSInteger quantity;
@property(nonatomic,copy,nullable)NSString *applicationUsername;
@property(nonatomic,assign)BOOL simulatesAskToBuyInSandbox;
@property(nonatomic,copy,nullable)void(^callback)(PaymentResult * _Nonnull);

-(instancetype)initWithProduct:(SKProduct *)product atomically:(BOOL)atomically quantity:(NSInteger)quantity applicationUsername:(NSString *)applicationUsername simulatesAskToBuyInSandbox:(BOOL)simulatesAskToBuyInSandbox callback:(void(^)(PaymentResult * _Nonnull))callback;


@end

NS_ASSUME_NONNULL_END
