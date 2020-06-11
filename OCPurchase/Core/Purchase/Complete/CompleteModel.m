//
//  CompleteModel.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "CompleteModel.h"

@implementation CompleteModel
-(instancetype)initWithAtomically:(BOOL)atomically callBack:(void (^)(CompleteResult * _Nonnull))callBack{
    if (self = [super init]) {
        self.atomically = atomically;
        self.callBack = callBack;
    }
    return self;
}
@end
