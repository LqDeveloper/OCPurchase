//
//  CompleteModel.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/11.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompleteResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface CompleteModel : NSObject
@property(nonatomic,assign)BOOL atomically;
@property(nonatomic,copy)void(^callBack)(CompleteResult*);

-(instancetype)initWithAtomically:(BOOL)atomically callBack:(void(^)(CompleteResult*))callBack;
@end

NS_ASSUME_NONNULL_END
