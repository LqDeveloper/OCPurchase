//
//  RestoreModel.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestoreResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface RestoreModel : NSObject
@property(nonatomic,assign)BOOL atomically;
@property(nonatomic,copy,nullable)NSString *applicationUsername;
@property(nonatomic,copy,nullable)void(^callBack)(RestoreResult *);

-(instancetype)initWithAtomically:(BOOL)atomically applicationUsername:(NSString *)applicationUsername callBack:(void(^)(RestoreResult *))callBack;

@end

NS_ASSUME_NONNULL_END
