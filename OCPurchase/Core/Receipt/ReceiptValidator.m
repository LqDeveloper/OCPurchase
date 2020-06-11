//
//  ReceiptValidator.m
//  OCPurchase
//
//  Created by Quan Li on 2020/6/9.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import "ReceiptValidator.h"

NSString * const  ProductionUrl = @"https://buy.itunes.apple.com/verifyReceipt";
NSString * const  SandboxUrl = @"https://sandbox.itunes.apple.com/verifyReceipt";

@interface ReceiptValidator()
@property(nonatomic,assign)ReceiptValidatorType type;
@property(nonatomic,copy)NSString *sharedSecret;
//excludeOldTransactions:Bool = false,将此值设置为true，以使响应仅包括任何订阅的最新续订交易。仅对包含自动续订的应用收据使用此字段。
@property(nonatomic,assign)BOOL excludeOldTransactions;
@end

@implementation ReceiptValidator
- (instancetype)initWithType:(ReceiptValidatorType)type sharedSecret:(NSString *)sharedSecret excludeOldTransactions:(BOOL)excludeOldTransactions{
    if (self = [super init]) {
        self.type = type;
        self.sharedSecret = sharedSecret;
        self.excludeOldTransactions = excludeOldTransactions;
    }
    return self;
}

- (instancetype)initWithType:(ReceiptValidatorType)type{
    if (self = [self initWithType:type sharedSecret:@"" excludeOldTransactions:false]) {
    }
    return self;
}



- (NSURLSessionDataTask *)validateWithData:(NSData *)receiptData completion:(void (^)(ValidateReceiptModel * _Nonnull))completion{
    if (receiptData == nil) {return nil;}
    NSString *url;
    if (self.type == ReceiptProduction) {
        url = ProductionUrl;
    }else{
        url = SandboxUrl;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"receipt-data"] = receiptData;
    if (self.sharedSecret != nil && ![self.sharedSecret isEqualToString:@""]) {
        parameter[@"password"] = self.sharedSecret;
    }
    
    if (self.excludeOldTransactions) {
        parameter[@"exclude-old-transactions"] = @YES;
    }
    
    NSError *error = nil;
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {return nil;}
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion([[ValidateReceiptModel alloc] initWithJson:nil error:error]);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
        if (jsonError) {
            completion([[ValidateReceiptModel alloc] initWithJson:nil error:jsonError]);
            return;
        }
        completion([[ValidateReceiptModel alloc] initWithJson:json error:nil]);
    }];
    [task resume];
    return task;
}
@end
