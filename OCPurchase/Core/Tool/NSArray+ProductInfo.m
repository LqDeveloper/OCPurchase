//
//  NSArray+ProductInfo.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/5.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "NSArray+ProductInfo.h"

@implementation NSArray (ProductInfo)
+(BOOL)equal:(NSArray<NSString *> *)arr1 withArray:(NSArray<NSString *> *)arr2{
    //判断两个数组的内容和顺序是否都相同，如果内容相同，但是顺序不同也是返回NO
    if ([arr1 isEqualToArray:arr2]) {return YES;}
    if (arr1.count != arr2.count) {return NO;}
    for (NSString *str in arr1) {
        if (![arr2 containsObject:str]) {
            return NO;
        }
    }
    return YES;
}
@end
