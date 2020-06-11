//
//  ReceiptValidator.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/9.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidateReceiptModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiptValidator : NSObject


-(instancetype)initWithType:(ReceiptValidatorType)type sharedSecret:(NSString *)sharedSecret excludeOldTransactions:(BOOL)excludeOldTransactions;

-(instancetype)initWithType:(ReceiptValidatorType)type;

-(NSURLSessionDataTask *)validateWithData:(NSData *)receiptData completion:(void(^)(ValidateReceiptModel * _Nonnull))completion;
@end

NS_ASSUME_NONNULL_END
