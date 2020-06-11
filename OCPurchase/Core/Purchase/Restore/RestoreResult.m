//
//  RestoreResult.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "RestoreResult.h"

@implementation RestoreResult
- (instancetype)initWithResults:(NSArray<PurchaseResult *> *)results{
    if (self = [super init]) {
        self.restoreResults = results;
    }
    return self;
}
@end
