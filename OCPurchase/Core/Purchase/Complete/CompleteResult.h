//
//  CompleteResult.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface CompleteResult : NSObject
@property(nonatomic,strong)NSArray<PurchaseResult *> *results;
-(instancetype)initWithResults:(NSArray<PurchaseResult *> *)results;
@end

NS_ASSUME_NONNULL_END
