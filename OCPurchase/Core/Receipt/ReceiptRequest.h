//
//  ReceiptRequest.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/9.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiptRequestDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReceiptRequest : NSObject
-(instancetype)initWithDelegate:(id<ReceiptRequestDelegate>)delegate;

//开始请求
-(void)start;

//取消请求
-(void)cancle;
@end

NS_ASSUME_NONNULL_END
