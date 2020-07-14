//
//  ProductController.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/5.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "ProductController.h"
#import "ProductInfoRequest.h"
#import "NSArray+ProductInfo.h"

@interface ProductInfoQuery : NSObject
@property(nonatomic,strong)ProductInfoRequest *request;
@property(nonatomic,strong)NSMutableArray<void(^)(ProductInfoModel *)> *blockArr;
@end
@implementation ProductInfoQuery
- (instancetype)initWithRequest:(ProductInfoRequest *)request
{
    self = [super init];
    if (self) {
        self.request = request;
        self.blockArr = [NSMutableArray array];
    }
    return self;
}
@end

@interface ProductController()<ProductRequestDelegate>
@property(nonatomic,strong)NSMutableArray<ProductInfoQuery *> *requestArr;
@end
@implementation ProductController
- (instancetype)init{
    if (self = [super init]) {
        self.requestArr = [NSMutableArray array];
    }
    return self;
}

- (void)requestWithProductIds:(NSArray<NSString *> *)productIds completion:(void (^)(ProductInfoModel * _Nonnull))completion{
    if (completion == nil) {return;}
    ProductInfoQuery *query = [self findQureyByIds:productIds];
    if (query == nil) {
        ProductInfoRequest *request = [[ProductInfoRequest alloc]initWithProductIds:productIds delegate:self];
        [request start];
        query = [[ProductInfoQuery alloc]initWithRequest:request];
        [query.blockArr addObject:completion];
        [self.requestArr addObject:query];
    }else{
        [query.blockArr addObject:completion];
    }
}



- (void)cancleWithProductIds:(NSArray<NSString *> *)productIds{
    ProductInfoQuery *query = [self findQureyByIds:productIds];
    [self removeQuery:query];
}


- (void)cancleAll{
    for (ProductInfoQuery *query in self.requestArr) {
        [query.request cancle];
        [query.blockArr removeAllObjects];
        query.request = nil;
        query.blockArr = nil;
    }
    [self.requestArr removeAllObjects];
}


-(ProductInfoQuery *)findQureyByIds:(NSArray<NSString *> *)productIds{
    for (ProductInfoQuery *query in self.requestArr) {
        if ([NSArray equal:query.request.productIds withArray:productIds]) {
            return query;
        }
    }
    return nil;
}

-(ProductInfoQuery *)findQureyByRequest:(ProductInfoRequest *)request{
    for (ProductInfoQuery *query in self.requestArr) {
        if (query.request == request) {
            return query;
        }
    }
    return nil;
}

-(void)removeQuery:(ProductInfoQuery *)query{
    [query.request cancle];
    query.request = nil;
    query.blockArr = nil;
    [query.blockArr removeAllObjects];
    [self.requestArr removeObject:query];
}

#pragma mark ProductRequestDelegate
- (void)requestSuccessWithRequest:(ProductInfoRequest *)request products:(NSArray<SKProduct *> *)products invalidProductIDs:(NSArray<NSString *> *)invalidIds{
    ProductInfoQuery *query = [self findQureyByRequest:request];
    dispatch_async(dispatch_get_main_queue(), ^{
        for (void (^block)(ProductInfoModel *) in query.blockArr) {
            block([[ProductInfoModel alloc] initWithProducts:products invalidIds:invalidIds error:nil]);
        }
        [self removeQuery:query];
    });
}

- (void)requestFailureWithRequest:(ProductInfoRequest *)request error:(NSError *)error{
    ProductInfoQuery *query = [self findQureyByRequest:request];
    dispatch_async(dispatch_get_main_queue(), ^{
        for (void (^block)(ProductInfoModel *) in query.blockArr) {
            block([[ProductInfoModel alloc] initWithProducts:nil invalidIds:nil error:error]);
        }
        [self removeQuery:query];
    });
}
@end
