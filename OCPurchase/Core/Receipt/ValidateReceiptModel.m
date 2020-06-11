//
//  ValidateReceiptModel.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/10.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "ValidateReceiptModel.h"

@implementation ValidateReceiptModel
-(instancetype)initWithJson:(NSDictionary *)json error:(NSError * _Nullable)error{
    if (self = [super init]) {
        self.json = json;
        self.error = error;
        [self setupStatus];
    }
    return self;
}

-(void)setupStatus{
    if (self.error) {
        self.status = Unknown;
        return;
    }

    if (self.json[@"status"]) {
        self.status = (ReceiptStatus)[self.json[@"status"] integerValue];
    }
}


@end
