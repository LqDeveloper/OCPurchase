//
//  ValidateReceiptModel.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/10.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiptEnum.h"
NS_ASSUME_NONNULL_BEGIN

@interface ValidateReceiptModel : NSObject
@property(nonatomic,copy,nullable)NSDictionary *json;
@property(nonatomic,strong,nullable)NSError *error;
@property(nonatomic,assign)ReceiptStatus status;

-(instancetype)initWithJson:(NSDictionary * _Nullable)json error:(NSError * _Nullable)error;
@end

NS_ASSUME_NONNULL_END
