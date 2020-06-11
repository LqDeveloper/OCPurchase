//
//  ReceiptRequest.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/9.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "ReceiptRequest.h"
#import <StoreKit/StoreKit.h>
@interface ReceiptRequest()<SKRequestDelegate>
@property(nonatomic,weak)id <ReceiptRequestDelegate> delegate;
@property(nonatomic,strong)SKReceiptRefreshRequest *request;
@end

@implementation ReceiptRequest
-(instancetype)initWithDelegate:(id<ReceiptRequestDelegate>)delegate{
    if (self = [super init]) {
        self.delegate = delegate;
        self.request = [[SKReceiptRefreshRequest alloc]init];
        self.request.delegate = self;
    }
    return self;
}

- (void)dealloc{
    [self.request cancel];
    self.request = nil;
    self.delegate = nil;
}


- (void)start{
    [self.request start];
}

- (void)cancle{
    [self.request cancel];
}


- (void)requestDidFinish:(SKRequest *)request{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(receiptRequestSuccess)] ) {
            [self.delegate receiptRequestSuccess];
        }
    });
}


- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(receiptRequestFailure:)] ) {
            [self.delegate receiptRequestFailure:error];
        }
    });
}
@end
