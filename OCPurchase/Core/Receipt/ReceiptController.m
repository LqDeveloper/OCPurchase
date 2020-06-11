//
//  ReceiptController.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/10.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "ReceiptController.h"
#import "ReceiptRequest.h"
#import "ReceiptValidator.h"
@interface ReceiptController()<ReceiptRequestDelegate>
@property(nonatomic,strong)ReceiptRequest *request;
@property(nonatomic,copy)void (^requestCompletion)(NSData * _Nullable, NSError * _Nullable);

@property(nonatomic,strong)ReceiptValidator *validator;
@end
@implementation ReceiptController

- (NSData *)receiptData{
    return [NSData dataWithContentsOfURL: [[NSBundle mainBundle] appStoreReceiptURL]];
}

- (void)requestReceipt:(BOOL)forceRefresh completion:(void (^)(NSData * _Nullable, NSError * _Nullable))completion{
    if (forceRefresh) {
        self.requestCompletion =  completion;
        self.request = [[ReceiptRequest alloc]initWithDelegate:self];
        [self.request start];
    }else{
        completion(self.receiptData,nil);
    }
}

- (void)requestReceipt:(void (^)(NSData * _Nullable, NSError * _Nullable))completion{
    [self requestReceipt:NO completion:completion];
}

- (void)cancleReceiptRequest{
    if (self.request) {
        [self.request cancle];
        self.request = nil;
        self.requestCompletion = nil;
    }
}


- (NSURLSessionDataTask *)validateWithType:(ReceiptValidatorType)type sharedSecret:(NSString *)sharedSecret excludeOldTransactions:(BOOL)excludeOldTransactions data:(NSData *)receiptData completion:(void (^)(ValidateReceiptModel * _Nonnull))completion{
    self.validator = [[ReceiptValidator alloc]initWithType:type sharedSecret:sharedSecret excludeOldTransactions:excludeOldTransactions];
    
    __weak typeof(self) weakSelf = self;
    return [self.validator validateWithData:receiptData completion:^(ValidateReceiptModel * _Nonnull result) {
        completion(result);
        weakSelf.validator = nil;
    }];
}


-(NSURLSessionDataTask *)validateWithType:(ReceiptValidatorType)type data:(NSData *)receiptData completion:(void (^)(ValidateReceiptModel * _Nonnull))completion{
    return [self validateWithType:type sharedSecret:@"" excludeOldTransactions:NO data:receiptData completion:completion];
}

- (void)dealloc{
    [self cancleReceiptRequest];
}


#pragma mark ReceiptRequestDelegate
- (void)receiptRequestFailure:(NSError * _Nullable)error {
    self.requestCompletion(nil, error);
    self.requestCompletion =  nil;
    self.request = nil;
}

- (void)receiptRequestSuccess {
    self.requestCompletion(self.receiptData, nil);
    self.requestCompletion =  nil;
    self.request = nil;
}

@end
