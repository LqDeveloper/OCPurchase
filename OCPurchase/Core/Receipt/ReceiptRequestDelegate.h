//
//  ReceiptRequestDelegate.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/10.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ReceiptRequestDelegate <NSObject>

/// 请求Receipt成功
-(void)receiptRequestSuccess;

/// 请求Receipt失败
/// @param error error
-(void)receiptRequestFailure:(NSError *_Nullable)error;
@end


NS_ASSUME_NONNULL_END
