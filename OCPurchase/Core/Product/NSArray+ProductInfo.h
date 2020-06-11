//
//  NSArray+ProductInfo.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/5.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray(ProductInfo)
+(BOOL)equal:(NSArray<NSString *> *)arr1 withArray:(NSArray<NSString *> *)arr2;
@end

NS_ASSUME_NONNULL_END
