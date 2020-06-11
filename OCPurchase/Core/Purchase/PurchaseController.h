//
//  PurchaseController.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/10.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaymentModel.h"
#import "RestoreModel.h"
#import "CompleteModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PurchaseController : NSObject
@property(nonatomic,copy,nullable)BOOL(^shouldAddStorePaymentHandler)(SKPayment *,SKProduct *);
@property(nonatomic,copy,nullable)void(^updatedDownloadsHandler)(NSArray<SKDownload *> *);

-(void)startPayment:(PaymentModel *)payment;

-(void)restore:(RestoreModel *)restoreModel;

-(void)complete:(CompleteModel *)complete;

-(void)finishTransaction:(SKPaymentTransaction *)transaction;

-(void)start:(NSArray <SKDownload *>*)downloads;

-(void)pause:(NSArray <SKDownload *>*)downloads;

-(void)resume:(NSArray <SKDownload *>*)downloads;

-(void)cancel:(NSArray <SKDownload *>*)downloads;
@end

NS_ASSUME_NONNULL_END
