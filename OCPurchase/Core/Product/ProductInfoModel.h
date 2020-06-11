//
//  ProductInfoModel.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/10.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ProductInfoModel : NSObject
@property(nonatomic,copy,nullable)NSArray<SKProduct*>* products;
@property(nonatomic,copy,nullable)NSArray <NSString *> *invalidIds;
@property(nonatomic,strong,nullable)NSError *error;

-(instancetype)initWithProducts:(NSArray<SKProduct*>* _Nullable)products invalidIds:(NSArray <NSString *> * _Nullable)invalidIds error:(NSError * _Nullable) error;
@end

NS_ASSUME_NONNULL_END
