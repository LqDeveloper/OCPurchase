//
//  RestoreResult.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface RestoreResult : NSObject
@property(nonatomic,copy)NSArray<PurchaseResult *> *restoreResults;
//通过这个属性来判断restore是否失败
@property(nonatomic,assign)BOOL isFailed;
@property(nonatomic,strong,nullable)NSError *error;
-(instancetype)initWithResults:(NSArray<PurchaseResult *> *)results;

@end

NS_ASSUME_NONNULL_END
