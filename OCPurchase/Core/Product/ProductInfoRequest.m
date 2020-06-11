//
//  ProductInfoRequest.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/5.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "ProductInfoRequest.h"
@interface ProductInfoRequest()<SKProductsRequestDelegate>
@property(nonatomic,copy,readwrite)NSArray<NSString *> *productIds;
@property(nonatomic,weak)id <ProductRequestDelegate> delegate;
@property(nonatomic,strong)SKProductsRequest *request;
@end

@implementation ProductInfoRequest
-(instancetype)initWithProductIds:(NSArray<NSString *> *)productIds delegate:(id<ProductRequestDelegate>)delegate{
    if (self = [super init]) {
        self.delegate = delegate;
        self.productIds = productIds;
        self.request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithArray:productIds]];
        self.request.delegate = self;
    }
    return self;
}

- (void)start{
    [self.request start];
}

- (void)cancle{
    [self.request cancel];
}

- (void)dealloc{
    [self.request cancel];
    self.request = nil;
    self.delegate = nil;
}


#pragma mark SKProductsRequestDelegate
-(void)requestDidFinish:(SKRequest *)request{}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestSuccessWithRequest:products:invalidProductIDs:)]) {
        [self.delegate requestSuccessWithRequest:self products:response.products invalidProductIDs:response.invalidProductIdentifiers];
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestFailureWithRequest:error:)]) {
        [self.delegate requestFailureWithRequest:self error:error];
    }
}
@end
