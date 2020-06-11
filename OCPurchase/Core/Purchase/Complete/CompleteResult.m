//
//  CompleteResult.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "CompleteResult.h"

@implementation CompleteResult
-(instancetype)initWithResults:(NSArray<PurchaseResult *> *)results{
    if (self = [super init]) {
        self.results = results;
    }
    return self;
}
@end
