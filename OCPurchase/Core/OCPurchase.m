//
//  OCPurchase.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/5.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "OCPurchase.h"
#import "ProductController.h"
#import "ReceiptController.h"
#import "PurchaseController.h"
@interface OCPurchase()
@property(nonatomic,strong)ProductController *product;
@property(nonatomic,strong)ReceiptController *receipt;
@property(nonatomic,strong)PurchaseController *purchase;
+(instancetype)shared;
@end


@implementation OCPurchase
+(instancetype)shared{
    static OCPurchase *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OCPurchase alloc]init];
    });
    return manager;
}

- (instancetype)init{
    if ([super init]) {
        self.product = [[ProductController alloc]init];
        self.receipt = [[ReceiptController alloc]init];
        self.purchase = [[PurchaseController alloc]init];
    }
    return self;
}

+(BOOL)canMakePayments{
    return SKPaymentQueue.canMakePayments;
}

+ (void)requestWithProductIds:(NSArray<NSString *> *)productIds completion:(void (^)(ProductInfoModel * _Nonnull))completion{
    [OCPurchase.shared.product requestWithProductIds:productIds completion:completion];
}


+(void)cancleWithProductIds:(NSArray<NSString *> *)productIds{
    [OCPurchase.shared.product cancleWithProductIds:productIds];
}


+(void)cancleAllProductRequest{
    [OCPurchase.shared.product cancleAll];
}


+ (NSData *)receiptData{
    return OCPurchase.shared.receipt.receiptData;
}


+(void)requestReceipt:(BOOL)forceRefresh completion:(void (^)(NSData * _Nullable, NSError * _Nullable))completion{
    [OCPurchase.shared.receipt requestReceipt:forceRefresh completion:completion];
}

+ (void)requestReceipt:(void (^)(NSData * _Nullable, NSError * _Nullable))completion{
    [OCPurchase.shared.receipt requestReceipt:completion];
}

+ (void)cancleReceiptRequest{
    [OCPurchase.shared.receipt cancleReceiptRequest];
}

+ (NSURLSessionDataTask *)validateWithType:(ReceiptValidatorType)type sharedSecret:(NSString *)sharedSecret excludeOldTransactions:(BOOL)excludeOldTransactions data:(NSData *)receiptData completion:(void (^)(ValidateReceiptModel * _Nonnull))completion{
    return [OCPurchase.shared.receipt validateWithType:type sharedSecret:sharedSecret excludeOldTransactions:excludeOldTransactions data:receiptData completion:completion];
}

+(NSURLSessionDataTask *)validateWithType:(ReceiptValidatorType)type data:(NSData *)receiptData completion:(void (^)(ValidateReceiptModel * _Nonnull))completion{
    return [OCPurchase.shared.receipt validateWithType:type data:receiptData completion:completion];
}

+ (void)finishTransaction:(SKPaymentTransaction *)transaction{
    [OCPurchase.shared.purchase finishTransaction:transaction];
}

+(void)purchaseProduct:(SKProduct *)product quantity:(NSInteger)quantity atomically:(BOOL)atomically applicationUsername:(NSString *)applicationUsername simulatesAskToBuyInSandbox:(BOOL)simulatesAskToBuyInSandbox callback:(void (^)(PaymentResult * _Nonnull))callback{
    PaymentModel *model = [[PaymentModel alloc]initWithProduct:product atomically:atomically quantity:quantity applicationUsername:applicationUsername simulatesAskToBuyInSandbox:simulatesAskToBuyInSandbox callback:callback];
    [OCPurchase.shared.purchase startPayment:model];
}

+(void)purchaseProduct:(SKProduct *)product callback:(void (^)(PaymentResult * _Nonnull))callback{
    PaymentModel *model = [[PaymentModel alloc]initWithProduct:product atomically:NO quantity:1 applicationUsername:@"" simulatesAskToBuyInSandbox:false callback:callback];
    [OCPurchase.shared.purchase startPayment:model];
}

+(void)restore:(BOOL)atomically applicationUsername:(NSString *)applicationUsername callBack:(void (^)(RestoreResult * _Nonnull))callBack{
    RestoreModel *model = [[RestoreModel alloc]initWithAtomically:atomically applicationUsername:applicationUsername callBack:callBack];
    [OCPurchase.shared.purchase restore:model];
}

+ (void)restoreWithCallBack:(void (^)(RestoreResult * _Nonnull))callBack{
    RestoreModel *model = [[RestoreModel alloc]initWithAtomically:YES applicationUsername:@"" callBack:callBack];
    [OCPurchase.shared.purchase restore:model];
}

+ (void)complete:(BOOL)atomically callBack:(void (^)(CompleteResult * _Nonnull))callBack{
    CompleteModel *model = [[CompleteModel alloc]initWithAtomically:atomically callBack:callBack];
    [OCPurchase.shared.purchase complete:model];
}

+ (void)completeWithCallBack:(void (^)(CompleteResult * _Nonnull))callBack{
    CompleteModel *model = [[CompleteModel alloc]initWithAtomically:YES callBack:callBack];
    [OCPurchase.shared.purchase complete:model];
}

+ (void)shouldAddStorePaymentHandler:(BOOL (^)(SKPayment * _Nonnull, SKProduct * _Nonnull))block{
    OCPurchase.shared.purchase.shouldAddStorePaymentHandler = block;
}

+(void)updatedDownloadsHandler:(void (^)(NSArray<SKDownload *> * _Nonnull))block{
    OCPurchase.shared.purchase.updatedDownloadsHandler = block;
}

+ (void)start:(NSArray<SKDownload *> *)downloads{
    [OCPurchase.shared.purchase start:downloads];
}

+ (void)pause:(NSArray<SKDownload *> *)downloads{
    [OCPurchase.shared.purchase pause:downloads];
}

+ (void)resume:(NSArray<SKDownload *> *)downloads{
    [OCPurchase.shared.purchase resume:downloads];
}

+ (void)cancel:(NSArray<SKDownload *> *)downloads{
    [OCPurchase.shared.purchase pause:downloads];
}
@end
