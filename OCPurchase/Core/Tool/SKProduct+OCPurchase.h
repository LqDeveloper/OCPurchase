//
//  SKProduct+OCPurchase.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/17.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKProduct (OCPurchase)
@property(nonatomic,copy,readonly)NSString *localizedPrice;
@property(nonatomic,copy,readonly)NSString *currency API_AVAILABLE(ios(10.0));
@end

NS_ASSUME_NONNULL_END
