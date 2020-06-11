//
//  ProductInfoModel.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/10.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "ProductInfoModel.h"

@implementation ProductInfoModel
- (instancetype)initWithProducts:(NSArray<SKProduct *> *)products invalidIds:(NSArray<NSString *> *)invalidIds error:(NSError *)error{
    if (self = [super init]) {
        self.products = products;
        self.invalidIds = invalidIds;
        self.error = error;
    }
    return self;
}
@end
