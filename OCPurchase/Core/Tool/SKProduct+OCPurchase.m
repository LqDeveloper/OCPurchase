//
//  SKProduct+OCPurchase.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/17.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "SKProduct+OCPurchase.h"

@implementation SKProduct (OCPurchase)
- (NSString *)localizedPrice{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.locale = self.priceLocale;
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    return  [formatter stringFromNumber:self.price];;
}

- (NSString *)currency{
    return self.priceLocale.currencyCode;
}
@end
