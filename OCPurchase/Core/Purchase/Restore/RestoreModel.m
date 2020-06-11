//
//  RestoreModel.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "RestoreModel.h"

@implementation RestoreModel
-(instancetype)initWithAtomically:(BOOL)atomically applicationUsername:(NSString *)applicationUsername callBack:(void (^)(RestoreResult * _Nonnull))callBack{
    if (self = [super init]) {
        self.atomically = atomically;
        self.applicationUsername = applicationUsername;
        self.callBack = callBack;
    }
    return self;
}
@end
